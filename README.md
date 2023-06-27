# Two separate optimisation tasks have been tackled. 
1. Interior_Point.m solves a linear program with a prototype interior point algorithm.
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/fc62d50c-309c-441a-8b35-d0000d1b48b6)

   ,where f is a 2×1 vector,while a1,a2 and b are each 16×1 vectors.

   This can be rewritten as:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/45f53ed2-8b92-49b7-8495-da04ef324ae9)

   The Cost is:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/89f8652f-3a11-4c8d-8aa6-6562a6ce5348)

   The Gradient is:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/064b5468-7577-4e14-b887-1c887456ff1e)

   The Hessian is:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/b8c4a855-0f05-49e3-8d90-db0abfb7be36)


   Vectors f, a1, a2 and b are loaded from lin_prog149.mat via load_data_lin_prog.m.
   Given these values, the figure of the constraint region overlaid with the location of the solutions to (*µ) is below:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/db430498-e239-40b7-bbf1-8fcce4784746)
   

3. Travel.m solves a travelling salesman problem using simulated annealing.
   

