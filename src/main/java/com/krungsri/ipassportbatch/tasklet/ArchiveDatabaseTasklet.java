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
public class ArchiveDatabaseTasklet implements Tasklet {

    private static final Logger logger = LoggerFactory.getLogger(ArchiveDatabaseTasklet.class);
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        try{
            logger.info("Archive IPASSPORT Database...");
            jdbcTemplate.execute("SET IMPLICIT_TRANSACTIONS OFF;EXEC sp_data_retention");
            logger.info("Archive IPASSPORT Database success.");
            return RepeatStatus.FINISHED;
        }catch (Exception e){
            logger.error("Archive IPASSPORT Database unsuccess {}",e.getMessage());
            return RepeatStatus.FINISHED;
        }
    }
}
