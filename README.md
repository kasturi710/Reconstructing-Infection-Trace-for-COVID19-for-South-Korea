# CSE8803-Data Science for Epidemiology
## Identifying Likely-Infected Nodes and Reconstructing the Infection Trace for COVID-19

### Overview

COVID-19 has infected more than 10,000 people in South Korea. We employ DS4C South Korea Patient dataset which is created using the information announced by KCDC (Korea Centers for Disease Control & Prevention) - [DS4C Dataset](https://www.kaggle.com/kimjihoo/coronavirusdataset) <br>
We have used the following files from the dataset to build the contact network. These files have been added in the `Dataset` folder in our repository. 
* `PatientInfo.csv`
* `Case.csv`

We majorly employ two algorithms to recover the infection trace and identify missing infections and seeds in the given infection trace:
* CULT
* NETFILL

### Preprocessing Data 

**Check out our [amazing preprocessing notebook](https://nbviewer.org/github/BonJovi1/CSE8803/blob/main/SOUTH%20KOREA%20COVID-19%20CASES%20DATASET%20PROCESSING%20FOR%20CULT%20AND%20NETFILL.ipynb)!**

In order to use these algorithms, we need to pre-process the dataset and scrape out relavant information from it. We have mentioned the pre-processing steps in the `SOUTH-KOREA-COVID-19-CASES-DATASET-PROCESSING-FOR-CULT-AND-NETFILL.ipynb` file. 

### Running CuLT
We employ CuLT to recover the flow of infection for the DS4C: South Korea dataset. We adapt the [code from the original paper](https://github.com/TPNguyen/reconstructing-an-epidemic-over-time) and make many modifications to it - for instance, (lines 48-134) in `demo.py` and render it suitable for our data. 

```
Polina Rozenshtein, Aristides Gionis, B. Aditya Prakash, Jilles Vreeken. "Reconstructing an Epidemic over Time", KDD '16
```

- For running the code on the DS4C dataset, simply run:

```
python2.7 demo.py
```

- The dataset is specified in line 16 of `demo.py`. Feel free to change it as per the dataset. All datasets are in the `Data` folder stored as `txt` files and are tab separated. 

```
dataset = 'korea-400'
```

In order to run it on the Flixter dataset, please ensure to uncomment line 490 in `utils/generator_noise.py` and comment line 492 (which works for DS4C). 

```
tstamp = datetime.strptime(items[0], '%Y-%m-%d %H:%M:%S')
```

We have also included the preprocessed south korea dataset in the `Datasets/south_korea_processed_dataset_for_CULT` folder.

### Running NETFILL
In order to run NETFILL, please follow the steps given in the README.md file of the NETFILL folder. We have included the preprocessed south korea dataset in the `Datasets/south_korea_processed_dataset_for_Netfill` folder. For convinience,  we have also included the required `mat` files for south korea and singapore data in the `NETFILL/sample_data` folder.







