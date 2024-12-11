package com.example.demo.dao;

import com.example.demo.model.Payment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PaymentMapper {
    List<Payment> findPaymentsForBuyer(@Param("email") String email);
}
