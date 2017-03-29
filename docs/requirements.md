# Requirements

### Summary
A system to manage community engagement in proposing and selecting public art projects.

### Purpose
The system serves two primary purposes:

1. Collection and exposition of ideas and proposals from and to the community.
2. Facilitation of community input on which ideas will receive funding.

### Roles
The system shall be designed for users with different roles -- these roles are:

* Admins - Site administrators who have the highest privileges, including creation of other users in other roles. They control and maintain the system.
* Moderators - Trusted users who have permissions to manage any data in the system unrelated to users (e.g. ideas, proposals, blog posts). They filter and revise site content.
* Steerers - Members of a "steering committee" who have permission to see most data in the system, even if it is not publically available, and are able to use this data to communicate with each other. They direct Pauselab's focus and draw insights from the community.
* Artists - Community members who propose public art projects to address community needs.
* Super Artists - Subset of artists who are selected to implement projects and report on their progress through a blog. They carry out the will of the community.
* Residents - Community members who view the system's published content and possibly submit ideas about improvements to an area. They are representatives of the community.

### Features
The system follows the lifecycle of one or more public art projects from its inception to its completion. As a result, it will have different views that are exposed at different times for each phase of a project. Site moderators will have the ability to change which phase is active.

**Idea Collection**: the community submits and views ideas about ways to improve certain areas.

* Residents will submit ideas through a simple form which contains their name, contact information (email and phone), and description of the idea (a choice of moderator-defined categories, some prose, location). _next semester_: to locate ideas, residents may place a pin on a map or write out the location through a text field. Residents need not prove their identity to submit ideas.
* Moderators can enter ideas if they receive them non-electronically.
* Moderators can see all submitted ideas through a table. Moderators can approve ideas after verifying their content is appropriate (this "publishes" the idea). Moderators can edit ideas for syntax or content, or delete them from the system.
* Residents will see published ideas on a map, where the idea's location corresponds with the area it would improve. Ideas will also be displayed in a card view and can be sorted by location, category, newest, most liked. Residents can "like" ideas to indicate interest early on.

**Proposal Collection**: artists submit proposals for solutions related to the community's ideas.

* Residents can no longer submit ideas.
* Artists will submit proposals through a more involved form which contains:
    * Idea(s) being addressed (through text)
    * Prose, and possibly images, about proposal
    * Attachments related to credentials
    * Budget estimates
* Moderators can enter proposals if they receive them non-electronically.
* Steerers can see proposals and make internal-facing comments regarding their feasibility.
* Moderators can see proposals and publish them after ensuring the project is feasible. Moderators can edit proposals for syntax or content, or delete them from the system.
* Residents will see published proposals through a grid and can sort by date.

**Proposal Voting**: the community votes on which projects will receive funding.

* Artists can no longer submit proposals.
* Residents can see published proposals through a grid. They will have a form to submit votes on their favorite proposals.
    * The form will collect the voter's name, email, phone, address, and have an honor statement that must be agreed to prior to submission.
    * They will select a finite number of proposals - 2 or 3 as their top choice.
    * They might allocate votes based on a specified budget. (not a desired feature)
    * _next semester_: Unlike "liking," voting needs protection against fraud, through a combination of CAPTCHA and "honor pledge."
* Moderators can enter votes if they receive them non-electronically.

**Project Implementation**: after projects are selected, the system presents feedback on their progress.

* Super artists and moderators can create blog posts containing prose and images to report progress about the selected projects.
* Residents can view blog posts in some type of chronological view. They can apply filters to select certain time periods.
* Ideas or proposals that did not receive funding are stored for future reference (e.g. if they can be applied to the next round).

**Site-wide Requirements**

* Integration with social media (Facebook, Twitter) during most if not all phases, to increase engagement with residents.
* Email assist capabilities for moderators/steerers to reach out to artists submitting proposals, and possibly residents submitting ideas.
* Website should be responsive on mobile.
* Website should be designed to be extensible to multiple languages.
* Residents do not need to create accounts. Artists do, and may do so on their own. Steerers, moderators, and admins need accounts and can only have them created by an admin.
* Only admins have the ability to manage user accounts.
* Some user roles (that is, steerer and artist) will have a "landing page" that contains static content (prose, image, and links to file downloads) about their responsibilities, as well as moderator-published updates. The moderator can post images, text, and links on the landing pages.
* The navbar at the top should adjust depending on the phase of the project. All phases will have "About" as static pages that the moderator can edit, as well as the "Blog" page.
    * Ideas phase: Ideas - Submit Idea, See Ideas
    * Proposals phase: Proposals - Submit Proposals, See Proposals; Ideas
    * Voting phase: Vote; Proposals; Ideas

### Deadlines

**Minimum Requirements**: All requirements defined under "Features" _except_ those in "Site-wide requirements" and noted as "next semester."

**Desired Requirements**: All requirements defined under "Features."

**Optional Requirements**: As defined by client.
