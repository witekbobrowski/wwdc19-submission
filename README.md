# WWDC19 Scholarship submission

<p align=center>
<a href="">
<img alt="screenshot" src="https://user-images.githubusercontent.com/18266391/56081679-57616880-5e10-11e9-8697-7e9e2db79801.png">
</a>
</p>
<p align=center>
    <a href="https://developer.apple.com/wwdc/"><img alt="WWDC" src="https://img.shields.io/badge/WWDC-2019-121b2e.svg"></a>
    <a href="https://swift.org"><img alt="Swift" src="https://img.shields.io/badge/Swift-4.2-oragne.svg"></a>
    <a href="https://developer.apple.com/wwdc/scholarships/"><img alt="Status" src="https://img.shields.io/badge/Status-submitted-blue.svg"></a>
</p>

### About

Welcome to my submission and thank you for checking it out! The goal of this
project was to create a simple Twitter clone that features Sentiment Analysis
of the tweets. And this is exactly what it does! Just like on twitter, you can
tweet - or rather quack - whatever is currently on your mind and share it with
the world - or at least a couple of Animoji friends that are currently 
registered to Quacker :) 

### Contents

##### 🦆 Quacker Xcode Playground
[`SentimentAnalysis.playground`](SentimentAnalysis.playground)

Obviously the most important part of the submission, Xcode Playground that is 
meant to be run on a mac computer with Xcode. Just before submitting I thought
that Swift Playground for iPad would be a better fit for my project but it was
already too late to chage it. Playground contains sources for `Quacker` with 
Machine Learning model attached. UI is built with UIKit in vanilla MVC architecture.
I wanted to really push the code quality and make the most of child view controllers, 
that is why you can find plenty of *UIViewController* subclasses that handle as little as 
a single *UIImageView* in this codebase.

##### 🧠 Jupyter Notebook with Machine Learning Model
[`SentimentAnalysis.ipynb`](SentimentAnalysis.ipynb)

This notebook contains source for model training using `Keras`, and also loading
dataset and preprocessing tweets with `Spacy`. The dataset contains 1.6mln tweets 
but to match the 25mb limit for submission I had to use only limited amount of
tweets and to further reduce the model size I removed words that occured only 
once. This had an impact on the accuracy of the model.

##### 🏗 Model Converter
[`keras2coreml.py`](keras2coreml.py)

Simple python script that converts Keras model to CoreML model using `coremltools`.
This process was the most frustrating since this conversion process basically broke
my model resulting in mediocre predictions. Additionally I had to use half-precision
so it could fit in the submission archive.

### Usage

1. Clone repository
2. Open Playground with Xcode
3. Have fun sending quacks with mediocre Sentiment Analysis
