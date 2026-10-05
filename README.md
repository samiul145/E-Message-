# E-Message V6 — Premium Onboarding + Auth Fix

This version fixes the onboarding **Create account / Log in** buttons.

## Supabase
1. Keep your existing E-Message schema, `call_signals`, username RPC, grants, and RLS.
2. Run `signup-profile-trigger-v6.sql` once in Supabase SQL Editor.
3. The signup username is sent as Supabase Auth metadata and the trigger creates the profile with that username.
4. Do not expose any `sb_secret_...` or service-role key in this browser app.

## Email confirmation
If Confirm email is enabled, account creation will show a message asking the user to check their email. This is expected Supabase behavior; the browser will not have an authenticated session until the email is confirmed.

## Run
Open `index.html` or host the folder on HTTPS/GitHub Pages. For camera/microphone calls, HTTPS is recommended/required by the browser.
