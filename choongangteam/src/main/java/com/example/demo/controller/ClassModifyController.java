package com.example.demo.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.Lesson;
import com.example.demo.model.UserSession;
import com.example.demo.service.ClassModifyService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ClassModifyController {
	private final ClassModifyService service;
	
	@Autowired
    private ServletContext servletContext;	
	
	@RequestMapping("classModify")
	public String classModify(@RequestParam("lesson_number") int lesson_number,
							  Model model) {
		
		Lesson lesson = service.getLesson(lesson_number);
		
		model.addAttribute("lesson", lesson);
		model.addAttribute("lesson_number", lesson_number);
		
		return "classModify/classModify";
	}
	
	@RequestMapping("deleteClass")
	@ResponseBody
	public int deleteClass(@RequestParam("lesson_number") int lesson_number,
							  Model model) {
		int result=0;
		result = service.deleteLesson(lesson_number);
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping("modify")
	public String modify(@ModelAttribute Lesson lesson,
			@RequestParam("lesson_keyword_insert") String keyword,
			@RequestParam("thumnail") MultipartFile tfile,
			@RequestParam("classImg") MultipartFile[] files,
			@RequestParam("lesson_content") String content,
			Model model) throws IOException {
		
		//섬네일을 그대로 두고 싶을때는 섬네일 파일값은 0이므로 이때 처리를 위한 변수
		int size = (int) tfile.getSize(); // 첨부파일의 크기 (단위:Byte)
		
		Lesson preLesson = service.getLesson(lesson.getLesson_number());
				
		// 1. content에서 img 태그의 src 값을 추출하여 이미지 경로 목록 만들기
		List<String> existingImagePaths = extractImagePathsFromContent(content);
		
		// 2. MultipartFile[]에서 content에 포함된 이미지만 남기기
		List<MultipartFile> filesToUpload = filterFilesByExistingImages(files, existingImagePaths);

		// 3. 파일 업로드 처리
		StringBuilder contentWithNewImagePaths = new StringBuilder(content);
		
		// 웹 애플리케이션 루트 경로
        String webAppRoot = servletContext.getRealPath("/");

        // "uimg" 폴더 경로
        String imagePath = webAppRoot + "uimg/";
        
        //컨탠츠 이미지 이름처리와 이미지를 모델 안에 넣을때 null값이 들어가는걸 방지하기 위한 변수
        int cnt=1;
        
        if(size>0) {
        	//섬네일처리 코드
        	String tfilename = tfile.getOriginalFilename(); // 첨부파일명
			Date td = new Date();
			SimpleDateFormat tsd = new SimpleDateFormat("_yyyyMMdd_HH_mm_ss");
			String tnewdate = tsd.format(td);
			String textension = tfilename.substring(tfilename.lastIndexOf("."), tfilename.length());
			String tnewFileName =  "thumbnail"+tnewdate+textension;
			tfile.transferTo(new File(imagePath + tnewFileName)); // 파일 저장
			lesson.setLesson_thumbnail(tnewFileName);
        }else {
        	lesson.setLesson_thumbnail(preLesson.getLesson_thumbnail());
        }
		
		//키워드 처리코드
		String[] key = keyword.split(",");
		String sumOfKeyword = new String();
		for(int i=0;i<key.length;i++) {
			key[i]=key[i].trim();
			
			if(i==0) sumOfKeyword= key[i];
			else sumOfKeyword+=(","+key[i]);
		}
		
		lesson.setLesson_keyword(sumOfKeyword);
		
		//content처리 코드
		for (MultipartFile file : filesToUpload) {
			if (!file.isEmpty()) {
				try {
					String filename = file.getOriginalFilename(); // 첨부파일명
					Date d = new Date();
					SimpleDateFormat sd = new SimpleDateFormat("_yyyyMMdd_HH_mm_ss");
					String newdate = sd.format(d);
					String extension = filename.substring(filename.lastIndexOf("."), filename.length());
					
					int index=0;
					for(int i=0;i<existingImagePaths.size();i++) {
						boolean isEqual = compareImages(existingImagePaths.get(i), file);
						if (isEqual) index=i;
					}

					String newFileName =  Integer.toString(cnt)+newdate+extension;
					
					if(lesson.getContent_image()==null) {
						lesson.setContent_image(newFileName);
					}else {
						lesson.setContent_image(lesson.getContent_image()+","+newFileName);
					}
					cnt++;
					file.transferTo(new File(imagePath + newFileName)); // 파일 저장
					
					// 정규 표현식으로 <img> 태그에서 src 속성 값 추출
					Pattern pattern = Pattern.compile("<img[^>]*src=\"(data:image[^\"]*)\"[^>]*>");
					Matcher matcher = pattern.matcher(content);

			        StringBuilder result = new StringBuilder();
			        int currentIndex = 0;

			        // 문자열을 순차적으로 처리하면서 <img> 태그를 찾음
			        while (matcher.find()) {
			            // 목표 인덱스에 해당하는 태그를 찾으면 src를 제거
			            if (currentIndex == index) {
			                // <img> 태그에서 src 속성값을 제거한 새로운 태그로 교체
			                String newImgTag = "<img src=\"/uimg/"+newFileName +"\"/>";
			                
			                // 결과에 새로운 태그 추가
			                result.append(content, 0, matcher.start());
			                result.append(newImgTag);  // 교체된 <img> 태그 추가
			                result.append(content, matcher.end(), content.length());
			            } 
			            currentIndex++;
			        }
					
					content=result.toString();
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				lesson.setContent_image(preLesson.getContent_image());
			}
		}
		lesson.setLesson_content(content);
		//디버그용 출력
//		System.out.println("title : "+lesson.getLesson_title());
//		System.out.println("content : "+lesson.getLesson_content());
//		System.out.println("Start_date : "+lesson.getStart_date());
//		System.out.println("Start_hour : "+lesson.getStart_hour());
//		System.out.println("Start_min : "+lesson.getStart_min());
//		System.out.println("Class_hour : "+lesson.getClass_hour());
//		System.out.println("Class_min : "+lesson.getClass_min());
//		System.out.println("keyword : "+lesson.getLesson_keyword());
//		System.out.println("price : "+lesson.getLesson_price());
//		System.out.println("apply : "+lesson.getLesson_apply());
//		System.out.println("thumbnail : "+lesson.getLesson_thumbnail());
//		System.out.println("image : "+lesson.getContent_image());
//		System.out.println("Maincategory : "+lesson.getMaincategory_number());
//		System.out.println("Subcategory : "+lesson.getSubcategory_number());
		int result = service.updateClass(lesson);
		
		model.addAttribute("lesson_number", lesson.getLesson_number());
		model.addAttribute("result", result);
		

		return "classModify/modifyResult";
	}

	/**
	 * content 내에서 img 태그의 src 값을 추출하여 이미지 경로 목록을 만든다.
	 */
	private List<String> extractImagePathsFromContent(String content) {
		List<String> imagePaths = new ArrayList<>();
		Pattern pattern = Pattern.compile("<img[^>]*src=\"(data:image[^\"]*)\"[^>]*>");
		Matcher matcher = pattern.matcher(content);

		while (matcher.find()) {
			imagePaths.add(matcher.group(1)); // src 값을 리스트에 추가
		}

		return imagePaths;
	}

	/**
	 * content에 포함된 이미지 경로와 일치하는 파일만 남기고 나머지 파일을 제외한다.
	 * @throws IOException 
	 */
	private List<MultipartFile> filterFilesByExistingImages(MultipartFile[] files, List<String> existingImagePaths) throws IOException {
		List<MultipartFile> filesToUpload = new ArrayList<>();

		for (MultipartFile file : files) {
			for(String img : existingImagePaths) {
				boolean isEqual = compareImages(img, file);
				if (isEqual) filesToUpload.add(file);
			}
		}
		
		return filesToUpload;
	}
	
	// Base64로 인코딩된 이미지를 바이너리로 디코딩
    public byte[] decodeBase64Image(String base64Image) {
        String base64Data = base64Image.split(",")[1]; // 'data:image/jpeg;base64,' 부분을 제거
        return Base64.decodeBase64(base64Data);
    }

    // MultipartFile 이미지를 바이너리 데이터로 변환
    public byte[] getFileBytes(MultipartFile file) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        outputStream.write(file.getBytes());
        return outputStream.toByteArray();
    }

    // 두 이미지를 비교
    public boolean compareImages(String base64Image, MultipartFile file) throws IOException {
        byte[] base64ImageBytes = decodeBase64Image(base64Image);
        byte[] fileBytes = getFileBytes(file);

        // 두 배열의 내용이 일치하는지 비교
        return Arrays.equals(base64ImageBytes, fileBytes);
    }
}
