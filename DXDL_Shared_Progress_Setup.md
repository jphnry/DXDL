# Shared progress for the DXDL Playbook

The preview page keeps the attached board's sections, assignments, dates, cyan header and updated footer. Its checkboxes are disabled until the database is configured. The existing public board remains unchanged during setup.

## Activate

1. Create a Supabase project. In its SQL Editor, run `DXDL_Shared_Progress_Setup.sql`.
2. In Table Editor, add the lowercase email addresses of the people who may edit progress to `public.playbook_editors`. You can start with your own email and add JP, Danny and Yin when you have their actual addresses.
3. In Supabase Auth → URL Configuration, add `https://jphnry.github.io/DXDL/KLM_DXDL_Playbook_Shared_Preview.html` to the allowed redirect URLs. Enable email sign-in.
4. Copy the project URL and **publishable/anon key** from Supabase project settings into the `shared-config` JSON near the end of `KLM_DXDL_Playbook_Shared_Preview.html`. The publishable key is intended for browser use; never use a service role or secret key in this file.
5. Commit the configured preview file to GitHub. Open the preview link and sign in with an allowlisted email. Test one checkbox in a second browser. It should appear on load and refresh automatically while open (every 12 seconds).
6. When the preview works, copy its configured contents over the existing `KLM_DXDL_Playbook_Ownership.html` to keep the current public link. Add that final URL to the Supabase redirect allowlist too.

The page reads shared progress for anyone who can open the public link. Only email allowlisted users can write, enforced by database row-level security. Text and owner edits made on the page still save locally until the updated HTML is committed to GitHub.

Existing browser checkmarks are not copied automatically. If needed, use the migration button in the configured page while signed in; it imports only locally checked items and never clears shared items.
