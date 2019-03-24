//
// SentimentalAnalysisModelFP16.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13.2, iOS 11.2, tvOS 11.2, watchOS 4.2, *)
class SentimentalAnalysisModelFP16Input : MLFeatureProvider {

    /// input1 as 1 element vector of doubles
    var input1: MLMultiArray

    /// lstm_11_h_in as optional 100 element vector of doubles
    var lstm_11_h_in: MLMultiArray? = nil

    /// lstm_11_c_in as optional 100 element vector of doubles
    var lstm_11_c_in: MLMultiArray? = nil

    var featureNames: Set<String> {
        get {
            return ["input1", "lstm_11_h_in", "lstm_11_c_in"]
        }
    }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "input1") {
            return MLFeatureValue(multiArray: input1)
        }
        if (featureName == "lstm_11_h_in") {
            return lstm_11_h_in == nil ? nil : MLFeatureValue(multiArray: lstm_11_h_in!)
        }
        if (featureName == "lstm_11_c_in") {
            return lstm_11_c_in == nil ? nil : MLFeatureValue(multiArray: lstm_11_c_in!)
        }
        return nil
    }

    init(input1: MLMultiArray, lstm_11_h_in: MLMultiArray? = nil, lstm_11_c_in: MLMultiArray? = nil) {
        self.input1 = input1
        self.lstm_11_h_in = lstm_11_h_in
        self.lstm_11_c_in = lstm_11_c_in
    }
}

/// Model Prediction Output Type
@available(macOS 10.13.2, iOS 11.2, tvOS 11.2, watchOS 4.2, *)
class SentimentalAnalysisModelFP16Output : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// Sentimental value for sequence of words from input as 1 element vector of doubles
    lazy var sentiment: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "sentiment")!.multiArrayValue
        }()!

    /// lstm_11_h_out as 100 element vector of doubles
    lazy var lstm_11_h_out: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "lstm_11_h_out")!.multiArrayValue
        }()!

    /// lstm_11_c_out as 100 element vector of doubles
    lazy var lstm_11_c_out: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "lstm_11_c_out")!.multiArrayValue
        }()!

    var featureNames: Set<String> {
        return self.provider.featureNames
    }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(sentiment: MLMultiArray, lstm_11_h_out: MLMultiArray, lstm_11_c_out: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["sentiment" : MLFeatureValue(multiArray: sentiment), "lstm_11_h_out" : MLFeatureValue(multiArray: lstm_11_h_out), "lstm_11_c_out" : MLFeatureValue(multiArray: lstm_11_c_out)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13.2, iOS 11.2, tvOS 11.2, watchOS 4.2, *)
class SentimentalAnalysisModelFP16 {
    var model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: SentimentalAnalysisModelFP16.self)
        return bundle.url(forResource: "SentimentalAnalysisModelFP16", withExtension:"mlmodelc")!
    }

    /**
     Construct a model with explicit path to mlmodelc file
     - parameters:
     - url: the file url of the model
     - throws: an NSError object that describes the problem
     */
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
     Construct a model with configuration
     - parameters:
     - configuration: the desired model configuration
     - throws: an NSError object that describes the problem
     */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
     Construct a model with explicit path to mlmodelc file and configuration
     - parameters:
     - url: the file url of the model
     - configuration: the desired model configuration
     - throws: an NSError object that describes the problem
     */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
     Make a prediction using the structured interface
     - parameters:
     - input: the input to the prediction as SentimentalAnalysisModelFP16Input
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as SentimentalAnalysisModelFP16Output
     */
    func prediction(input: SentimentalAnalysisModelFP16Input) throws -> SentimentalAnalysisModelFP16Output {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
     Make a prediction using the structured interface
     - parameters:
     - input: the input to the prediction as SentimentalAnalysisModelFP16Input
     - options: prediction options
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as SentimentalAnalysisModelFP16Output
     */
    func prediction(input: SentimentalAnalysisModelFP16Input, options: MLPredictionOptions) throws -> SentimentalAnalysisModelFP16Output {
        let outFeatures = try model.prediction(from: input, options:options)
        return SentimentalAnalysisModelFP16Output(features: outFeatures)
    }

    /**
     Make a prediction using the convenience interface
     - parameters:
     - input1 as 1 element vector of doubles
     - lstm_11_h_in as optional 100 element vector of doubles
     - lstm_11_c_in as optional 100 element vector of doubles
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as SentimentalAnalysisModelFP16Output
     */
    func prediction(input1: MLMultiArray, lstm_11_h_in: MLMultiArray?, lstm_11_c_in: MLMultiArray?) throws -> SentimentalAnalysisModelFP16Output {
        let input_ = SentimentalAnalysisModelFP16Input(input1: input1, lstm_11_h_in: lstm_11_h_in, lstm_11_c_in: lstm_11_c_in)
        return try self.prediction(input: input_)
    }

    /**
     Make a batch prediction using the structured interface
     - parameters:
     - inputs: the inputs to the prediction as [SentimentalAnalysisModelFP16Input]
     - options: prediction options
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as [SentimentalAnalysisModelFP16Output]
     */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [SentimentalAnalysisModelFP16Input], options: MLPredictionOptions = MLPredictionOptions()) throws -> [SentimentalAnalysisModelFP16Output] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [SentimentalAnalysisModelFP16Output] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  SentimentalAnalysisModelFP16Output(features: outProvider)
            results.append(result)
        }
        return results
    }
}
