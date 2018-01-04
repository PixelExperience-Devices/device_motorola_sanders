/*
 * Copyright (c) 2016 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.moto.actions;

import android.os.Bundle;
import android.support.v7.preference.Preference;
import android.support.v14.preference.PreferenceFragment;
import android.support.v14.preference.SwitchPreference;
import android.os.UserHandle;
import android.provider.Settings;
import android.content.Context;
import android.content.res.Resources;

public class GestureSettingsFragment extends PreferenceFragment {

    private SwitchPreference mGestureDoubleTapPower;

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        getActivity().getActionBar().setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        addPreferencesFromResource(R.xml.actions_panel);
        mGestureDoubleTapPower = (SwitchPreference) findPreference("gesture_double_tap_power");
        if (isCameraDoubleTapPowerAllowed()){
            mGestureDoubleTapPower.setChecked(isCameraDoubleTapPowerEnabled());
            mGestureDoubleTapPower.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
                @Override
                public boolean onPreferenceChange(Preference preference, Object objValue) {
                    boolean value = (Boolean) objValue;
                    setCameraDoubleTapPowerEnabled(value);
                    return true;
                }
            });
            try {
                Resources settingsRes = getActivity().createPackageContext("com.android.settings", 0).getResources();
                mGestureDoubleTapPower.setTitle(settingsRes.getString(
                        settingsRes.getIdentifier("double_tap_power_for_camera_title", "string", "com.android.settings")));
                mGestureDoubleTapPower.setSummary(settingsRes.getString(
                        settingsRes.getIdentifier("double_tap_power_for_camera_summary", "string", "com.android.settings")));
            } catch (Exception e) {
            }
        }else{
            getPreferenceScreen().removePreference(mGestureDoubleTapPower);
        }
    }

    private boolean isCameraDoubleTapPowerAllowed() {
        return getActivity().getResources().getBoolean(
                com.android.internal.R.bool.config_cameraDoubleTapPowerGestureEnabled);
    }

    private boolean isCameraDoubleTapPowerEnabled(){
        return Settings.Secure.getIntForUser(getActivity().getContentResolver(),
                        Settings.Secure.CAMERA_DOUBLE_TAP_POWER_GESTURE_DISABLED, 1, UserHandle.USER_CURRENT) == 1;
    }

    private void setCameraDoubleTapPowerEnabled(boolean enabled){
        Settings.Secure.putInt(getActivity().getContentResolver(),
                Settings.Secure.CAMERA_DOUBLE_TAP_POWER_GESTURE_DISABLED, enabled ? 0 : 1);
    }

}
