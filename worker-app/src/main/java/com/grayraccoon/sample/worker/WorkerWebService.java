package com.grayraccoon.sample.worker;

import lombok.Data;
import lombok.ToString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
@RequestMapping("/ws")
public class WorkerWebService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WorkerWebService.class);

    @GetMapping("/info")
    public BasicInfo getBasicInfo() throws UnknownHostException {
        LOGGER.info("Getting basic Info.");
        final InetAddress ip = InetAddress.getLocalHost();
        final BasicInfo basicInfo = new BasicInfo();
        basicInfo.setAddress( ip.toString() );
        basicInfo.setHostname( ip.getHostName() );
        LOGGER.info("Returning basic info: {}", basicInfo);
        return basicInfo;
    }

    @Data
    @ToString
    private static class BasicInfo {
        private String address;
        private String hostname;
    }

}
