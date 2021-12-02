# CSE8803-Data Science for Epidemiology
## Reconstructing the Covid-19 Infection Trace for South Korea

COVID-19 has infected more than 10,000 people in South Korea. We employ DS4C South Korea Patient dataset which is created using the information announced by KCDC (Korea Centers for Disease Control & Prevention) https://www.kaggle.com/kimjihoo/coronavirusdataset <br>
We have used the following files from the dataset to build the contact network. 
* PatientInfo.csv
* Case.csv

Note that these files have been added in the Dataset folder in our repository.

We majorly employ two algorithms to recover the infection trace and identify missing infections and seeds in the given infection trace:
* CULT
* NETFILL

In order to use these algorithms, we need to pre-process the dataset and scrape out relavant information from it. We have mentioned the pre-processing steps in the 'SOUTH-KOREA-COVID-19-CASES-DATASET-PROCESSING-FOR-CULT-AND-NETFILL.ipynb' file.

In order to run CULT, please follow the steps given in the README.md file of the CULT folder. We have included the preprocessed south korea dataset in the Datasets/south_korea_processed_dataset_for_CULT folder.

In order to run NETFILL, please follow the steps given in the README.md file of the NETFILL folder. We have included the preprocessed south korea dataset in the Datasets/south_korea_processed_dataset_for_Netfill folder. For convinience,  we have also included the required mat files for south korea and singapore data in the NETFILL/sample_data folder.







