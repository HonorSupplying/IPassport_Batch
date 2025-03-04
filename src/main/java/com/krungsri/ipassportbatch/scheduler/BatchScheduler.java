package com.krungsri.ipassportbatch.scheduler;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.Year;

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

    //@Scheduled(cron = "0 0 0 * * *") // Every Day @ midnight
    @Scheduled(cron = "0 */1 * * * *")  // Every 1 minute for testing
    public void scheduleClearCustomerData() throws Exception {
        jobLauncher.run(clearCustomerData, new JobParameters());
    }

    //@Scheduled(cron = "0 0 * * * ?") // Every hour
    @Scheduled(cron = "0 */1 * * * *") // Every 1 minute for testing
    public void scheduleMarkExpiredTransaction() throws Exception {
        jobLauncher.run(markExpiredTransaction, new JobParameters());
    }

    @Scheduled(cron = "0 0 0 5 1 *") // Every year @ Date 5 January
    //@Scheduled(cron = "0 */1 * * * *") // Every 1 minute for testing
    public void scheduleDataRetention() throws Exception {
        int currentYear = Year.now().getValue();
        if (currentYear % 3 == 0) {
            jobLauncher.run(clearCustomerData,new JobParameters());
            jobLauncher.run(dataRetention, new JobParameters());
        }
    }

}
