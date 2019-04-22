//
//  TestAudioController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/22.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import CoreMedia
import CoreAudio

class TestAudioController: NoneNaviBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

/** 设置 编码器输入格式 */
        //这段代码就是输入格式的设置。这里用到了一个小技巧，设置编码器的输入格式是通过传入的第一个音频数据包来获得的。因为，在iOS中每个音视频的输入数据中都包含了必要的参数。而iOS也为我们提供了提取这些数据的方法，非常方便。
//        let inAudioStreamBasicDescription:AudioStreamBasicDescription = *CMAudioFormatDescriptionGetStreamBasicDescription(CMSampleBufferGetFormatDescription())

/** 设置 编码器输出格式 */
        
        //先将输出描述符清0
        var outAudioStreamBasicDescription:AudioStreamBasicDescription = AudioStreamBasicDescription.init(mSampleRate: 0, mFormatID: 0, mFormatFlags: 0, mBytesPerPacket: 0, mFramesPerPacket: 0, mBytesPerFrame: 0, mChannelsPerFrame: 0, mBitsPerChannel: 0, mReserved: 0)
        //采样率 44.1K
        outAudioStreamBasicDescription.mSampleRate = 44100
        //音频格式可以设置为
        //kAudioFormatMPEG4AAC_HE
        //kAudioFormatMPEG4AAC_HE_V2
        //kAudioFormatMPEG4AAC
        outAudioStreamBasicDescription.mFormatID = kAudioFormatMPEG4AAC
        //指明格式的细节，设置为0说明没有子格式。
        //如果mFormatID 设置为kAudioFormatMPEG4AAC_HE 该值应该为0
        outAudioStreamBasicDescription.mFormatFlags = AudioFormatFlags(MPEG4ObjectID.AAC_LC.rawValue)
        //每个音频包的字节数
        //该字段设置为 0，表明包里的字节数是变化的。
        //对于使用可变包大小的格式，请使用AudioStreamPacketDescription结构指定每个数据包的大小。
        outAudioStreamBasicDescription.mBytesPerPacket = 0
        //每个音频包帧的数量，对于未压缩的数据设置为1.
        //动态码率格式，这个值是一个较大的固定数字，比如说AAC的1024.
        //如果是动态帧数（比如0gg格式）设置为0。
        outAudioStreamBasicDescription.mFramesPerPacket = 1024
        //每个帧的字节数。对于压缩数据，设置为0。
        outAudioStreamBasicDescription.mBytesPerFrame = 0
        //音频声道数
        outAudioStreamBasicDescription.mChannelsPerFrame = 1
        //压缩数据，该值设置为0。
        outAudioStreamBasicDescription.mBitsPerChannel = 0
        //用于字节对齐，必须是0。
        outAudioStreamBasicDescription.mReserved = 0
        
/** 创建编解码器 */
        
        //创建编码器除了上面说的要设置输入输出数据格式外，还要告诉 AudioToolbox 是创建编码器还是创建解码器；是创建 AAC 的，还是创建OPUS的；是硬编码还是软编码。
        //iOS为我们提供了 AudioClassDescription 来描述这些信息。它包括下面三个字段:mType、mSubType、mManufacturer
        //mType: 指明提编码器还是解码器。kAudioDecoderComponentType／kAudioEncoderComponentType。
        //mSubType: 指明是 AAC, iLBC 还是 OPUS等。
        //mManufacturer: 指明是软编还是硬编码。
        
        /*
        了解了上面的信息后，我们再来看下面的代码就很好理解了。
        
        首先通过 AudioFormatGetPropertyInfo 获取音频属性信息。在这里就是获得所有与 格式ID一致的描术信息的个数。格式ID在这里就是 kMPEG4Object_AAC_LC
        然后，使用 AudioFormatGetProperty 获取音频格式属性值，在这里就是得到所有的音频描述符。
        找到与用户指定一致的描述符。
        最后调用 AudioConverterNewSpecific 创建转码器。*/
        
//        var audioClassDescription:AudioClassDescription
//        memset(&audioClassDescription, 0, sizeof(audioClassDescription))
    }
}
