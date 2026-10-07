# BIOL4315_Lab5

# Download File
download.file(
  url = "https://mothur.s3.us-east-2.amazonaws.com/wiki/miseqsopdata.zip",
  destfile = here::here("data/miseqsopdata.zip"))

# unzip the to get individual fastq files
unzip("data/miseqsopdata.zip")

# record path to data
data_dir <- here::here("data/MiSeq_SOP")