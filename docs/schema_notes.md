Schema:
------

Idea:
+ first_name: string
+ last_name: string
+ phone: string
+ description: text
+ location: string
+ category: category_id
+ status: boolean
+ likes: integer

Project:
...

Category:
+ id: int
+ name: string

Proposal
+ artist: artist_id (foreign key)
+ idea: idea_id (foreign key)
+ cost_estimate: int
+ description: text
+ essay: file
+ status: boolean

Artist
+ first_name: string
+ last_name: string
+ email: string
+ phone: string
+ proposals_submitted: proposals submitted
+ current_project: project
+ password: password

User
+ first_name: string
+ last_name: string
+ email: string
+ phone: string
+ password: password

Role
+ user: user_id
+ type: string