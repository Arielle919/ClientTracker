User Stories "Client Tracker"
=============
<h3>User Stories</h3>

<h5>
    As a Sales Associate<br>
    I want to view a list of all of my clients along with the task for each client<br>
    In Order to know which clients are active and also see task needed to be done for each client.
<h5>

<h6>
    Usage: ./ClientTracker stats "Clients" "Tasks"
</h6>

<h6>Acceptance Criteria:<br>
    <ul>
        <li>A list of clients and client task along with follow-up dates are printed 
        categorized by the correct client</li>
    </ul>
</h6>

<h5>
    As a Sales Associate<br>
    I want to be able to check off the task done for my clients<br>
    In Order for me to know which clients I need to follow up with to get those unfinished task done.
<h5>

<h6>
    Usage: ./ClientTracker stats "Clients" "Tasks"<br>
    Usage: ./ClientTracker stats "John Doe" "Task" "processing"<br>
    Usage: ./ClientTracker stats "John Doe" "Task" "completed"
</h6>

<h6>Acceptance Criteria:<br>
    <ul>
        <li>A list of Clients and task will print out</li>
        <li>The Correct task status will be categorized under the correct client</li>
        <li>If task is "processing" it's status will be "uncompleted"</li>
        <li>If task is "completed" it's status will be "completed"</li>
    </ul>
</h6>

<h5>
    As a Sales Associate<br>
    I want to view a list of all the clients and dates I've followed up with them<br>
    In Order for me to know which clients that I need to pay more attention to before
    they discontinue my services.
<h5>

<h6>
    Usage: ./ClientTracker stats "Clients" "FollowUps"
</h6>

<h6>Acceptance Criteria:<br>
    <ul>
        <li>A list of clients along with follow-up dates are printed adjacently</li>
        <li> If client has more than one follow-up date, it will be hidden </li>
        <li> Clients with multiple follow-up dates will show only on that particular client's indiviual lookup</li>
    </ul>
</h6>

<h5>
    As a Sales Associate<br>
    I want to be able to input my client's name, date followed up, and task for client<br>
    In Order for me to have my unique list that I'm familiar with so that my business
    can grow.
<h5>

<h6>
    Usage: ./ClientTracker stats "John Doe" "01/15/2014" "John needs to fill out Membership Forms"
</h6>

<h6>Acceptance Criteria:<br>
    <ul>
        <li>A way for user to input their own data (client, follow-up date, and task for each client)</li>
        <li>Once data is inputed this data will be added to the The Client List</li>
        <li>Each client has their own ID number so the user can look up Clients indiviually</li>
        
    </ul>
</h6>

<h5>
    As a Sales Associate<br>
    I want to be able to update or delete my clients when necessary<br>
    In Order to know which client's task and follow-up dates need to be updated
    and to also not get confused on which clients are no longer using my services.
<h5>

<h6>
    Usage: ./ClientTracker stats "Clients" "03" "update"<br>
    Usage: ./ClientTracker stats "Clients" "03" "delete"
</h6>

<h6>Acceptance Criteria:<br>
    <ul>
        <li>The client's task and follow-up dates can be updated or deleted by user</li>
        <li>The user can either update a task already created or add a task to intended list under client</li>
        <li>The user can update list of follow-up dates by adding dates to intended client</li>
        <li>If the user observes that pass follow-up date is incorrect, they can update the date intended</li>
    </ul>
</h6>
