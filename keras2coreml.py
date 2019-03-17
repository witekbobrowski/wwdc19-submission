import coremltools

coreml_model = coremltools.converters.keras.convert(model='SentimentalAnalysis.h5')
coreml_model.save('SentimentalAnalysis.mlmodel')
