package com.example.kiit_cgpa_calculator;

import android.os.Build;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowInsetsController;
import android.view.WindowManager;
import androidx.core.view.WindowCompat;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Window window = getWindow();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Ensure edge-to-edge display for Android 11+
            WindowCompat.setDecorFitsSystemWindows(window, false);
            WindowInsetsController insetsController = window.getInsetsController();

            if (insetsController != null) {
                // Hide system bars with swipe gesture
                insetsController.setSystemBarsBehavior(WindowInsetsController.BEHAVIOR_SHOW_BARS_BY_SWIPE);
            }
        } else {
            // Fallback for Android 10 and below
            window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
        }
    }
}
