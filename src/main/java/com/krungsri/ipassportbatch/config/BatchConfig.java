package com.krungsri.ipassportbatch.config;

import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.support.TaskExecutorJobLauncher;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


//@Configuration
//public class BatchConfig {
//    @Bean
//    public JobLauncher jobLauncher(JobRepository jobRepository) {
//        TaskExecutorJobLauncher jobLauncher = new TaskExecutorJobLauncher();
//        jobLauncher.setJobRepository(jobRepository);
//        return jobLauncher;
//    }
//}
