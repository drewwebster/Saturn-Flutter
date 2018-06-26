package com.example.stellaris;

import android.os.Bundle;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.test/test";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
              new MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall methodCall, Result result) {
                      if (methodCall.method.equals("getMessage")) {
                          String message = "Hello from Android native";
                          result.success(message);
                      }
                  }
              }
      );
  }
}
