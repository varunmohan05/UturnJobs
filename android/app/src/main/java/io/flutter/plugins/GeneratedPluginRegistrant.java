package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin;
import com.mr.flutter.plugin.filepicker.FilePickerPlugin;
import io.flutter.plugins.firebaseauth.FirebaseAuthPlugin;
import io.flutter.plugins.firebase.core.FirebaseCorePlugin;
import io.flutter.plugins.firebase.storage.FirebaseStoragePlugin;
import com.sidlatau.flutteremailsender.FlutterEmailSenderPlugin;
import flutterlaunch.thyagoluciano.com.flutter_launch.FlutterLaunchPlugin;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
import com.dataxad.fluttermailer.FlutterMailerPlugin;
import com.example.flutter_sms.FlutterSmsPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import com.razorpay.razorpay_flutter.RazorpayFlutterPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    CloudFirestorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin"));
    FilePickerPlugin.registerWith(registry.registrarFor("com.mr.flutter.plugin.filepicker.FilePickerPlugin"));
    FirebaseAuthPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebaseauth.FirebaseAuthPlugin"));
    FirebaseCorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.core.FirebaseCorePlugin"));
    FirebaseStoragePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.storage.FirebaseStoragePlugin"));
    FlutterEmailSenderPlugin.registerWith(registry.registrarFor("com.sidlatau.flutteremailsender.FlutterEmailSenderPlugin"));
    FlutterLaunchPlugin.registerWith(registry.registrarFor("flutterlaunch.thyagoluciano.com.flutter_launch.FlutterLaunchPlugin"));
    FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    FlutterMailerPlugin.registerWith(registry.registrarFor("com.dataxad.fluttermailer.FlutterMailerPlugin"));
    FlutterSmsPlugin.registerWith(registry.registrarFor("com.example.flutter_sms.FlutterSmsPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    RazorpayFlutterPlugin.registerWith(registry.registrarFor("com.razorpay.razorpay_flutter.RazorpayFlutterPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
