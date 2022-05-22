#import "TorchModule.h"
#import <Libtorch-Lite/Libtorch-Lite.h>

@implementation TorchModule {
@protected
	torch::jit::mobile::Module _impl;
}

- (nullable instancetype)initWithFileAtPath:(NSString*)filePath {
	self = [super init];
	if (self) {
		try {
			_impl = torch::jit::_load_for_mobile(filePath.UTF8String);
		} catch (const std::exception& exception) {
			NSLog(@"%s", exception.what());
			return nil;
		}
	}
	return self;
}

- (NSArray<NSNumber*>*)predictId:(void*)ids mask:(void*)mask {
	
	at::Tensor tensor1 = torch::from_blob(ids, {1, 512}, at::kInt);
	at::Tensor tensor2 = torch::from_blob(mask, {1, 512}, at::kInt);
	
	std::vector<torch::jit::IValue> inputs;
	inputs.push_back(tensor1);
	inputs.push_back(tensor2);
	
	auto outputTensor = _impl.forward(inputs).toTensor();
	float* floatBuffer = outputTensor.data_ptr<float>();
	if (!floatBuffer) {
		return nil;
	}
	NSMutableArray* results = [[NSMutableArray alloc] init];
	for (int i = 0; i < 4; i++) {
		[results addObject:@(floatBuffer[i])];
	}
	return [results copy];
//	try {
//		
//		
//	} catch (const std::exception& exception) {
//		NSLog(@"АААААА%s", exception.what());
//	}
//	return nil;
	
}

- (NSArray<NSNumber*>*)predictImage:(void*)imageBuffer {
	try {
		
		at::Tensor tensor = torch::from_blob(imageBuffer, {1, 3, 224, 224}, at::kFloat);
		c10::InferenceMode guard;
		auto outputTensor = _impl.forward({tensor}).toTensor();
		float* floatBuffer = outputTensor.data_ptr<float>();
		if (!floatBuffer) {
			return nil;
		}
		NSMutableArray* results = [[NSMutableArray alloc] init];
		for (int i = 0; i < 1000; i++) {
			[results addObject:@(floatBuffer[i])];
		}
		return [results copy];
	} catch (const std::exception& exception) {
		NSLog(@"%s", exception.what());
	}
	return nil;
}

@end

