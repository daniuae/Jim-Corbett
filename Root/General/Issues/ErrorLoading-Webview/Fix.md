The MySQL server is working correctly. Your second screenshot proves that:

MySQL 8.0.46 is running.
sudo mysql connects successfully.
The problem is not with MySQL, SQL syntax, or your database.

The error in the first screenshot:

Error loading webview: Could not register service worker: InvalidStateError: Failed to register a serviceWorker

is a VS Code Web/remote lab webview problem. The SQL result window is failing to load.

Fix — try these in order
1. Reload the VS Code page

In the browser containing the Learnlytica VS Code environment:

Press:

Ctrl + Shift + R

Wait for the entire VS Code environment to reload.

Then run:

SHOW DATABASES;

and:

SHOW TABLES;
2. If still broken, close the VS Code browser tab

Do not stop MySQL.

Close only the browser tab containing the VS Code environment.

Then reopen your Learnlytica lab URL.

Your MySQL server should still be running.

3. Clear the site's stored data — most likely fix

Since the error specifically mentions a service worker, clear the browser data for the Learnlytica lab.

In Chrome:

Open the Learnlytica lab page.
Click the lock/settings icon beside the URL.
Choose Site settings.
Select Delete data / Clear data.
Close the tab.
Reopen the lab.

Then reconnect to the database.

This does not delete your MySQL databases. It only clears browser-side data for the web IDE.

4. If the error continues, use Incognito

Open Chrome Incognito:

Ctrl + Shift + N

Open your Learnlytica lab URL there and log in.

If VS Code works normally in Incognito, the problem is almost certainly Chrome cache/service-worker/browser storage, not MySQL.

5. Restart the VS Code web environment

If the lab provides a Restart / Reconnect / Restart Environment option, use that.

After reconnecting, open your SQL file again and test:

SELECT VERSION();

You should get something similar to:

8.0.46-0ubuntu0.22.04.3

You can also verify the database:

USE milestone_224K;

SHOW TABLES;
Important: your SQL editor itself is fine

From your first screenshot, you have:

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

and then:

SHOW TABLES;

The green check beside the query indicates the SQL execution succeeded.

The failure is occurring after execution, when VS Code tries to display the Result webview.

So don't reinstall MySQL or recreate the database yet.

Quickest solution

I would do this first:

Close Learnlytica tab
        ↓
Open Chrome Incognito
        ↓
Open Learnlytica lab
        ↓
Reconnect VS Code
        ↓
Run SELECT VERSION();
        ↓
Run SHOW TABLES;

If it works in Incognito, clear the Learnlytica site's browser data in your normal Chrome profile.

Also, in the terminal, instead of typing just version, use:

SELECT VERSION();

or inside the MySQL prompt:

\s

Both will correctly show the MySQL server version.
