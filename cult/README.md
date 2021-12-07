# reconstructing-an-epidemic-over-time

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
