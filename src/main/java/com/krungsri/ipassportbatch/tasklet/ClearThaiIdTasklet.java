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
public class ClearThaiIdTasklet implements Tasklet {

    private static final Logger logger = LoggerFactory.getLogger(ClearThaiIdTasklet.class);
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        try{
            logger.info("Clearing IPRO_TX_THAIID table...");
            jdbcTemplate.execute("EXEC sp_clear_thaiid");
            logger.info("IPRO_TX_THAIID cleared.");
            return RepeatStatus.FINISHED;
        }catch (Exception e){
            logger.error("Clearing IPRO_TX_THAIID table unsuccess {}",e.getMessage());
            return RepeatStatus.FINISHED;
        }
    }
}
