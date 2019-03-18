//
// SentimentalAnalysis.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class SentimentalAnalysisInput : MLFeatureProvider {

    /// input1 as 1 element vector of doubles
    var input1: MLMultiArray

    /// lstm_1_h_in as optional 100 element vector of doubles
    var lstm_1_h_in: MLMultiArray? = nil

    /// lstm_1_c_in as optional 100 element vector of doubles
    var lstm_1_c_in: MLMultiArray? = nil

    public var featureNames: Set<String> {
        get {
            return ["input1", "lstm_1_h_in", "lstm_1_c_in"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "input1") {
            return MLFeatureValue(multiArray: input1)
        }
        if (featureName == "lstm_1_h_in") {
            return lstm_1_h_in == nil ? nil : MLFeatureValue(multiArray: lstm_1_h_in!)
        }
        if (featureName == "lstm_1_c_in") {
            return lstm_1_c_in == nil ? nil : MLFeatureValue(multiArray: lstm_1_c_in!)
        }
        return nil
    }
    
    public init(input1: MLMultiArray, lstm_1_h_in: MLMultiArray? = nil, lstm_1_c_in: MLMultiArray? = nil) {
        self.input1 = input1
        self.lstm_1_h_in = lstm_1_h_in
        self.lstm_1_c_in = lstm_1_c_in
    }
}

/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class SentimentalAnalysisOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// output1 as 1 element vector of doubles
    public lazy var output1: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "output1")!.multiArrayValue
    }()!

    /// lstm_1_h_out as 100 element vector of doubles
    public lazy var lstm_1_h_out: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "lstm_1_h_out")!.multiArrayValue
    }()!

    /// lstm_1_c_out as 100 element vector of doubles
    public lazy var lstm_1_c_out: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "lstm_1_c_out")!.multiArrayValue
    }()!

    public var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    public init(output1: MLMultiArray, lstm_1_h_out: MLMultiArray, lstm_1_c_out: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["output1" : MLFeatureValue(multiArray: output1), "lstm_1_h_out" : MLFeatureValue(multiArray: lstm_1_h_out), "lstm_1_c_out" : MLFeatureValue(multiArray: lstm_1_c_out)])
    }

    public init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class SentimentalAnalysis {
    public var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    public class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: SentimentalAnalysis.self)
        return bundle.url(forResource: "SentimentalAnalysis", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    public init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    public convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration
        - parameters:
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    public convenience init(configuration: MLModelConfiguration) throws {
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
    public init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as SentimentalAnalysisInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as SentimentalAnalysisOutput
    */
    public func prediction(input: SentimentalAnalysisInput) throws -> SentimentalAnalysisOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as SentimentalAnalysisInput
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as SentimentalAnalysisOutput
    */
    public func prediction(input: SentimentalAnalysisInput, options: MLPredictionOptions) throws -> SentimentalAnalysisOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return SentimentalAnalysisOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - input1 as 1 element vector of doubles
            - lstm_1_h_in as optional 100 element vector of doubles
            - lstm_1_c_in as optional 100 element vector of doubles
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as SentimentalAnalysisOutput
    */
    public func prediction(input1: MLMultiArray, lstm_1_h_in: MLMultiArray?, lstm_1_c_in: MLMultiArray?) throws -> SentimentalAnalysisOutput {
        let input_ = SentimentalAnalysisInput(input1: input1, lstm_1_h_in: lstm_1_h_in, lstm_1_c_in: lstm_1_c_in)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [SentimentalAnalysisInput]
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [SentimentalAnalysisOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    public func predictions(inputs: [SentimentalAnalysisInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [SentimentalAnalysisOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [SentimentalAnalysisOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  SentimentalAnalysisOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
