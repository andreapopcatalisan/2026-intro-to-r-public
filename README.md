# Introduction to Programming in R
This is a course for the Analysis and Policy and Economics M1 program at the Paris School of Economics.

The objective of this course is to provide you with the necessary bases in R programming to be able to carry out your empirical homework and research projects in the program. The course is structured in 4 classes of 2 hours. No preliminary knowledge of programming is required, but part of the content of the last lecture is based on what you're going to see in Econometrics I. **Each class may take place in a different classroom at Campus Jourdan. Please bring your own laptop to practice during the sessions.**

This course is mostly based on [Maria Montoya-Aguirre's](https://mariamontoyaa.github.io/) slides (former TA of this course), [Louis Sirugue Intro to Programming in R course](https://louissirugue.github.io/intro_to_R/home.html) at PSE and the [Development Research in Practice Handbook](https://worldbank.github.io/dime-data-handbook/) and [RA onboarding trainings](https://osf.io/wzjtk/) by DIME Analytics. See the resources slides at the end of each lecture for specific references on each topic. 

## Before the first class:
- [ ] 💻 Install R and R Studio.
- [ ] 🐈‍⬛ Create a GitHub account
- [ ] 📥 Download the materials in the data folder (it can take a few days to set up your Wi-Fi access on campus) 

## Class policies:
- Respect your classmates and teacher. 
- There is no grade on this class, **BUT** I highly encourage you to take it seriously. If you pay your full attention in class and do the homework, you will have a great foundation of programming skills. This will pay off when you do your Econometrics homework and (later on) if you work on applied research for your master's thesis or work as a research assistant.

## Lectures:
You can find the pdf version of the slides in the `slides` folder. 
1. Data manipulation (Sept 16)
    - [📄 Open slides](https://andreapopcatalisan.github.io/2026-intro-to-r-public/slides/01_data-manipulation-noanswers.html#1); [Data](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/data) and [Code](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/code/class1)
3. Data visualization (Sept 20)
    - [📄 Open Slides](https://andreapopcatalisan.github.io/2026-intro-to-r-public/slides/02_data-visualization.html#1); [Data](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/data) and [Code](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/code/class2)
4. R Markdown, LaTeX and other tools for reproducible research (Sept 30)
    - [📄 Open Slides](https://andreapopcatalisan.github.io/2026-intro-to-r-public/slides/03_reports-Rmd-Latex.html#1); [Data](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/data) and [Code](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/code/class3)
6. Econometrics in R (Oct 7)
    - [📄 Open Slides](https://andreapopcatalisan.github.io/2026-intro-to-r-public/slides/04_econometrics.html#1); [Data](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/data) and [Code](https://github.com/andreapopcatalisan/2026-intro-to-r-public/tree/2026-intro-to-r-public/code/class4)

   
## 📝 Homework 1: Data Manipulation  


### ✅ Task 1: Inspect the IMDB dataset

Use `glimpse()` and `table()` to explore the dataset. Identify **5 issues** that should be addressed in the data cleaning or tidying process that we **haven’t covered in class**.

For each issue:
- Briefly describe the problem
- Suggest at least **one function** that could help fix it  
- You’re encouraged to Google or use R help tools!

**Example**:  
The `year` variable is not numeric and contains string characters.  
Suggested functions: `str_length()`, `str_sub()`, `as.numeric()`

 
### ✅ Task 2: Are older movies better?

Use what you’ve learned to explore whether older movies tend to have higher ratings.

1. **Fix the year variable** — clean it to extract the numeric year  
2. **Create a new variable** that indicates whether a movie is older or more recent than the average year in the dataset  
3. **Group by decade** (starting from the 1950s) and calculate the average rating for each decade

 
### ✅ Task 3: AI Reflection

After completing the coding portion — or after at least **30 minutes of trying on your own** — you may use an AI tool (e.g., ChatGPT) to get help.

Add a short reflection at the bottom of your script:

1. What prompt did you give to the AI? (Paste it)
2. What kind of answer did it give you? Was it helpful? Why or why not? Did it contain any errors?
3. How did you adapt or modify what the AI gave you, if at all?

**📎Submit** Please send me your solutions at andreapopcatalisan@gmail.com with [intro-to-R + NAME + H1], as the subject.

---
## 📝 Homework 2: Data Visualization


Use the `02_playfair-wages-wheat.sv` dataset and replicate [this graph](slides/playfair-wages-wheat.png) as best as you can using `ggplot()`

  - 🆗 OK: Plotting wheat prices, wages and the timeline of English rulers in the right geoms and colors
  - 👍🏽 Great: Getting the axes (you might need `dup_axis()`) and the overall appearance of the geoms as similar as you can, as well as including the annotation in the middle of the graph ("Chart showing...")
  - 🤩 Amazing: Adding the label over the wages series ("Weekly wages of a good mechanic"), customizing the appearance of the grid and including the labels of the English rulers 

Add a short reflection at the bottom of your script:

1. What prompt did you give to the AI? (Paste it)
2. What kind of answer did it give you? Was it helpful? Why or why not? Did it contain any errors?
3. How did you adapt or modify what the AI gave you, if at all?

**📎Submit** Please send me your solutions at andreapopcatalisan@gmail.com with [intro-to-R + NAME + H2], as the subject.

---


## Do you have a question, you can't access the material or your code doesn't run?
      
- 📬 If you prefer to send me a message **privately**:
    - Email me at andrea.pop@psemail.eu or andreapopcatalisan@gmail.com.
    - ⚠️ Don't forget to add `[intro-to-R]` at the beginning of the e-mail subject (otherwise it might get lost in my inbox)

  
