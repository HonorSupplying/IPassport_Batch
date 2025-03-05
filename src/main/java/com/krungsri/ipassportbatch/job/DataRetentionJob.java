package com.krungsri.ipassportbatch.job;

import com.krungsri.ipassportbatch.tasklet.*;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class DataRetentionJob {

    public DataRetentionJob(){}

    @Bean
    public Job dataRetention(JobRepository jobRepository,Step archiveDatabaseStep,Step clearActivityStep,Step clearAuditTrailStep,Step clearTransactionStep){
        return new JobBuilder("dataRetention",jobRepository)
                .start(clearActivityStep)
                .next(clearAuditTrailStep)
                .next(clearTransactionStep)
                .build();
    }


    @Bean
    public Step clearActivityStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, ClearActivityTasklet clearActivityTasklet){
        return new StepBuilder("clearActivityStep",jobRepository)
                .allowStartIfComplete(true)
                .tasklet(clearActivityTasklet,transactionManager)
                .build();
    }

    @Bean
    public Step clearAuditTrailStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, ClearAuditTrailTasklet clearAuditTrailTasklet){
        return new StepBuilder("clearAuditTrailStep",jobRepository)
                .allowStartIfComplete(true)
                .tasklet(clearAuditTrailTasklet,transactionManager)
                .build();
    }

    @Bean
    public Step clearTransactionStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, ClearTransactionTasklet clearTransactionTasklet){
        return new StepBuilder("clearTransactionStep",jobRepository)
                .allowStartIfComplete(true)
                .tasklet(clearTransactionTasklet,transactionManager)
                .build();
    }


}
