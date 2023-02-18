package com.candidate.controller;

import com.candidate.logger.DPLogger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class CandidateController {

    private static final DPLogger log = DPLogger.getLogger(CandidateController.class);

    @GetMapping
    public Integer sumCompany() {
        log.info("islediiiiiiiiiiiiiiiiiiiiiiiiii");
        return 100;
    }
}


