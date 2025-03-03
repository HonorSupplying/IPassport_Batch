package com.krungsri.ipassportbatch.job;

import com.krungsri.ipassportbatch.tasklet.ClearThaiIdTasklet;
import com.krungsri.ipassportbatch.tasklet.MarkExpireTransactionTasklet;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class MarkExpireTransactionJob {

    public MarkExpireTransactionJob(){}

    @Bean
    public Job markExpireTransaction(JobRepository jobRepository, Step markExpireStep) {
        return new JobBuilder("markExpireTransaction", jobRepository)
                .start(markExpireStep)
                .build();
    }

    @Bean
    public Step markExpireStep(JobRepository jobRepository, PlatformTransactionManager transactionManager, MarkExpireTransactionTasklet markExpireTransactionTasklet) {
        return new StepBuilder("markExpireStep", jobRepository)
                .allowStartIfComplete(true)
                .tasklet(markExpireTransactionTasklet, transactionManager)
                .build();
    }

}
