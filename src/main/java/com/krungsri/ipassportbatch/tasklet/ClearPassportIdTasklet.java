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
public class ClearPassportIdTasklet implements Tasklet {

    private static final Logger logger = LoggerFactory.getLogger(ClearPassportIdTasklet.class);
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        try{
            logger.info("Clearing IPRO_TX_PASSPORTID table...");
            jdbcTemplate.execute("EXEC sp_clear_passportid");
            logger.info("IPRO_TX_PASSPORTID cleared.");
        }catch (Exception e){
            logger.error("Clearing IPRO_TX_PASSPORTID table Fail {}",e.getMessage());
        }
        return RepeatStatus.FINISHED;
    }
}
