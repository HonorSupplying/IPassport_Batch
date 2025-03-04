package com.krungsri.ipassportbatch.tasklet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class MarkExpireTransactionBeforeDailyClearTasklet implements Tasklet {

    private static final Logger logger = LoggerFactory.getLogger(MarkExpireTransactionBeforeDailyClearTasklet.class);
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        try{
            logger.info("Updating Expire IPRO_TX_TRANSACTION table...");
            jdbcTemplate.execute("EXEC sp_mark_expire_before_daily_clear");
            logger.info("IPRO_TX_TRANSACTION Update success.");
        }catch (Exception e){
            logger.error("Updating IPRO_TX_TRANSACTION table Fail {}",e.getMessage());
        }
        return RepeatStatus.FINISHED;
    }
}
