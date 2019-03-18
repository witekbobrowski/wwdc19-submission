import coremltools

# Load keras model and convert to CoreML
model = coremltools.converters.keras.convert(
    model='SentimentalAnalysis.h5',
    input_names='words',
    output_names='sentiment'
)

# Set model metadata
model.author = 'Witek Bobrowski'
model.license = 'MIT'
model.short_description = 'Predicts the sentimental value for a sequence of words in English Language'

# Set feature descriptions manually
model.input_description['words'] = 'Sequence of IDs correspoding to words'

# Set the output description
model.output_description['sentiment'] = 'Sentimental value for sequence of words from input'

# Save the model
model.save('SentimentalAnalysis.mlmodel')
