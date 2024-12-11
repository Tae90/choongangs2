package com.example.demo.service;

import com.example.demo.dao.PaymentMapper;
import com.example.demo.model.Payment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MyClassService {

    @Autowired
    private PaymentMapper paymentMapper;

    public List<Payment> getPurchasedClasses(String email) {
        return paymentMapper.findPaymentsForBuyer(email);
    }
}
