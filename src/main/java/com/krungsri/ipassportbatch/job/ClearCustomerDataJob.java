package com.krungsri.ipassportbatch.job;

import com.krungsri.ipassportbatch.tasklet.ClearPassportIdTasklet;
import com.krungsri.ipassportbatch.tasklet.ClearThaiIdTasklet;
import com.krungsri.ipassportbatch.tasklet.MarkExpireTransactionBeforeDailyClearTasklet;
import com.krungsri.ipassportbatch.tasklet.MarkExpireTransactionTasklet;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class ClearCustomerDataJob {

    public ClearCustomerDataJob() {}

    @Bean
    public Job clearCustomerData(JobRepository jobRepository, Step clearPassportIdStep, Step clearThaiIdStep,Step markExpireStep) {
        return new JobBuilder("clearCustomerData", jobRepository)
                .start(markExpireStep)
                .next(clearPassportIdStep)
                .next(clearThaiIdStep)
                .build();
    }

    @Bean
    public Step clearPassportIdStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, ClearPassportIdTasklet clearPassportIdTasklet) {
        return new StepBuilder("clearPassportIdStep", jobRepository)
                .allowStartIfComplete(true)
                .tasklet(clearPassportIdTasklet, transactionManager)
                .build();
    }

    @Bean
    public Step clearThaiIdStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, ClearThaiIdTasklet clearThaiIdTasklet){
        return new StepBuilder("clearThaiIdStep",jobRepository)
                .allowStartIfComplete(true)
                .tasklet(clearThaiIdTasklet,transactionManager)
                .build();
    }

    @Bean
    public Step markExpireStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, MarkExpireTransactionTasklet markExpireTransactionTasklet){
        return new StepBuilder("markExpireBeforeClearStep",jobRepository)
                .allowStartIfComplete(true)
                .tasklet(markExpireTransactionTasklet,transactionManager)
                .build();
    }
}
