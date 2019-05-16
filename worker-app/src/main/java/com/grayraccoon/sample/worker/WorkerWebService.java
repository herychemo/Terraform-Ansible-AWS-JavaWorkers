package com.grayraccoon.sample.worker;

import lombok.Data;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
@RequestMapping("/ws")
public class WorkerWebService {

    @GetMapping("/info")
    public BasicInfo getBasicInfo() throws UnknownHostException {
        final InetAddress ip = InetAddress.getLocalHost();
        final BasicInfo basicInfo = new BasicInfo();
        basicInfo.setAddress( ip.toString() );
        basicInfo.setHostname( ip.getHostName() );
        return basicInfo;
    }

    @Data
    private static class BasicInfo {
        private String address;
        private String hostname;
    }

}
