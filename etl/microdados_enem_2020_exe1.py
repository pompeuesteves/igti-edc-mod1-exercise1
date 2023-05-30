import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

#Ler dados do enem 2020
enem = (
    spark.read.format("csv").option("header", True).option("inferSchema",True).option("delimiter",";").load("s3://datalake-guilherme-713051429766/raw-data/")
    )

#Salvar dados do enem 2020 formato parquet
(
    enem.write.mode("overwrite").format("parquet").partitionBy("NU_ANO").save("s3://datalake-guilherme-713051429766/consumer-zone/")
    )

job.commit()