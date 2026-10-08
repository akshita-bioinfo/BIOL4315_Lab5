# BIOL4315_Lab5

# Download File
download.file(
  url = "https://mothur.s3.us-east-2.amazonaws.com/wiki/miseqsopdata.zip",
  destfile = here::here("data/miseqsopdata.zip"))

# unzip the to get individual fastq files
unzip("data/miseqsopdata.zip")

# record path to data
data_dir <- here::here("data/MiSeq_SOP")

# check
list.files(data_dir)

# examine metadata file
read.delim(base::paste(data_dir,"mouse.dpw.metadata", sep = "/" ))[
  order(read.delim(base::paste(data_dir,"mouse.dpw.metadata", sep = "/" ))[[2]]),]

# download reference data genome
# Taxonomy file
download.file(
  url = "https://zenodo.org/record/4587955/files/silva_nr99_v138.1_wSpecies_train_set.fa.gz?download=1",
  destfile = here::here(here::here("data/silva_nr99_v138.1_wSpecies_train_set.fa.gz")))

# Required packages
BiocManager::install("dada2")
BiocManager::install("phyloseq")

# loading libraries
lapply(c("dada2","phyloseq","vegan","tidyverse",
         "Biostrings"), library, character.only = T)

#----------GETTING STARTED--------------#
# All forward and reverse fastq file names have the exact format: samplename_r1_001.fastq and samplename_r2_001.fastq
# Note the pattern
fnFs <- sort(list.files(data_dir, pattern="_R1_001.fastq", full.names = TRUE))
fnRs <- sort(list.files(data_dir, pattern="_R2_001.fastq", full.names = TRUE))

#basename removes the folder names
sample.names <- stringr::str_split_fixed(basename(fnFs),"_",2)[,1]
sample.names


#----------QUALITY CHECK----------------#
# forward read quality
plotQualityProfile(fnFs[1:2])

# reverse read quality
plotQualityProfile(fnRs[1:2])


#-----------TRIMMING & FILTERING--------#
#R1
filtFs <- here::here("outputs/filtered", paste0(sample.names, "_F_filt.fastq.gz"))
names(filtFs) <- sample.names

#R2
filtRs <- here::here("outputs/filtered", paste0(sample.names, "_R_filt.fastq.gz"))
names(filtRs) <- sample.names

