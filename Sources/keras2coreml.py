import keras
import coremltools

loaded_model = keras.models.load_model('SentimentalAnalysisModel.h5')

# Load keras model and convert to CoreML
model = coremltools.converters.keras.convert(
        loaded_model,
        output_names='sentiment'
)

# Set model metadata
model.author = 'Witek Bobrowski'
model.license = 'MIT'
model.short_description = 'Predicts the sentimental value for a sequence of words in English Language'

# Set the output description
model.output_description['sentiment'] = 'Sentimental value for sequence of words from input'

# Save the model
model.save('SentimentalAnalysisModel.mlmodel')

# Also save Half Precistion model
model_spec = coremltools.utils.load_spec('SentimentalAnalysisModel.mlmodel')
model_fp16_spec = coremltools.utils.convert_neural_network_spec_weights_to_fp16(model_spec)
coremltools.utils.save_spec(model_fp16_spec, 'SentimentalAnalysisModelFP16.mlmodel')
