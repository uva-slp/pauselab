# PauseLab [![Build Status](https://travis-ci.com/uva-slp/pauselab.svg?token=cgdzy9p3574R8NZyrL3d&branch=master)](https://travis-ci.com/uva-slp/pauselab)

This web app was developed by students from the [UVa Computer Science](https://engineering.virginia.edu/departments/computer-science) [Service Learning Practicum](https://github.com/uva-slp) course for [PauseLab](http://pauselab.com/), a Charlottesville organization that initiates and enables creative projects that address community needs. The system is meant to simplify future iterations of the [BeCville](https://becville.org/) 2016-17 participatory budgeting initiative, in which the community proposed and selected public art projects that utilized a $15000 investment in the neighborhood.

The system is constructed for the administration of three different functions which are employed in order over a period of several months: idea elicitation and collection (the public suggests ways to improve the community), project proposal collection (artists submit plans for community projects that synthesize the public's ideas), and vote collection (the public selects proposals to be funded). There are also other features such as user administration, news posting, and mass mailing. To learn more about the system, see the [technical report](docs/technical-report.pdf).

## Installation and Usage

This system is a [Rails 5](http://rubyonrails.org/) app; for deployment we used [AWS](https://aws.amazon.com/), following [these instructions](docs/installation-instructions.md).

Once the system is set up, learn how to use it with our [user manual](docs/user-manual.pdf). Then, feel free to fork and modify, extend, and/or improve the system with some help from our [programming reference](docs/programming-reference.pdf).

We are not actively maintaining this system and may not respond to pull requests in a timely manner. You are of course welcome to adapt it for your own purposes (e.g. other participatory budgeting or community engagement projects).

## Repo Organization

* `Scripts`: some code used to automate deployment on a development server using Travis CI
* `app`: the actual Rails 5 project
* [`docs`](docs/readme.md): info and documentation on this project

## License

This project is released under the [MIT license](./LICENSE).
