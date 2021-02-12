create or replace pipe LANDING.MARKETING_ANALYTICS.CANCEL_PLAN_RATE  AUTO_INGEST=TRUE
    as

COPY INTO "PROD"."MARKETING_ANALYTICS"."CANCEL_PLAN_RATE"
                                        FROM (SELECT $1 ,$2
                                        , METADATA$FILENAME AS FILENAME
                                        , TO_TIMESTAMP_TZ(CURRENT_TIMESTAMP()) as DB_LOAD_TMSTP 
                                                from  @PROD.MARKETING_ANALYTICS.S3_GOALS_PLAN/Cancel_Plan_Rate/)
                                        FILE_FORMAT = (TYPE = 'CSV'
                                                    FIELD_DELIMITER = ','
                                                    SKIP_HEADER = 1
                                                    DATE_FORMAT = AUTO)

                                        --FORCE = TRUE
                                        ON_ERROR = CONTINUE