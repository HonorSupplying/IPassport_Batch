package com.krungsri.ipassportbatch.scheduler;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class BatchScheduler {

    private JobLauncher jobLauncher;

    private Job clearCustomerData;

    private Job markExpiredTransaction;

    private Job dataRetention;

    @Autowired
    public void setJobLauncher(JobLauncher jobLauncher){
        this.jobLauncher = jobLauncher;
    }

    @Autowired
    @Qualifier("clearCustomerData")
    public void setClearCustomerData(Job clearCustomerData){
        this.clearCustomerData = clearCustomerData;
    }

    @Autowired
    @Qualifier("markExpireTransaction")
    public void setMarkExpiredTransaction(Job markExpiredTransaction){
        this.markExpiredTransaction = markExpiredTransaction;
    }

    @Autowired
    @Qualifier("dataRetention")
    public void setDataRetention(Job dataRetention){
        this.dataRetention = dataRetention;
    }

    //@Scheduled(cron = "0 0 * * * ?") // Every hour
    @Scheduled(cron = "0 */1 * * * *")  // Every 1 minute for testing
    public void scheduleClearCustomerData() throws Exception {
        jobLauncher.run(clearCustomerData, new JobParameters());
    }

    //@Scheduled(cron = "0 0 * * * ?") // Every hour
    @Scheduled(cron = "0 */1 * * * *") // Every 1 minute for testing
    public void scheduleMarkExpiredTransaction() throws Exception {
        jobLauncher.run(markExpiredTransaction, new JobParameters());
    }

    //@Scheduled(cron = "0 0 * * * ?") // Every hour
    @Scheduled(cron = "0 */1 * * * *") // Every 1 minute for testing
    public void scheduleDataRetention() throws Exception {
        jobLauncher.run(dataRetention, new JobParameters());
    }

}
