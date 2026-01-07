// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

 @Envied(path: '.env')
 abstract class Env {
     @EnviedField(varName: 'supaBaseURL')
     static String supaBaseUrl = _Env.supaBaseUrl;

     @EnviedField(varName: 'supaBaseAnnonKey', obfuscate: true)
     static String supaBaseAnnonkey = _Env.supaBaseAnnonkey;

     /*@EnviedField(varName: 'baseUrl')
     static String baseUrl = _Env.baseUrl;

     @EnviedField(varName: 'appId',obfuscate: true)
     static String appId = _Env.appId;
   
     @EnviedField(varName: 'restKey',obfuscate: true)
     static String restKey = _Env.restKey;

     @EnviedField(varName: 'clientKey',obfuscate: true)
     static String clientKey = _Env.clientKey;*/
    
 }