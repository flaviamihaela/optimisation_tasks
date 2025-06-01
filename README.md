# Optimisation Tasks

This project showcases two classic optimisation algorithms - an interior point solver for linear programs and a simulated annealing heuristic for the Travelling Salesman Problem. Each algorithm demo includes a visualiser - we can identify the feasible region or see TSP tour in real time!

| Optimisation Task                              | Description                                                                                                                                    | Core Files                                                                         |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| **Interior-Point Linear Program** | Solves a 2-variable linear program with an interior-point Newton method and draws the feasible region and iterate path | `load lin_prog149` (data)  `lin_prog_core.m` (solver)  `lp_visualize.m` (data loader + plotter) |
| **Simulated-Annealing TSP**       | Searches for a short tour through 40 points (clubs) using annealing heuristic                                                 | `load travel_sale149` (data)  `tsp_core.m` (solver)  `tsp_visualize.m` (data loader + plotter)  |

## Key Features
- Newton direction with backtracking to remain strictly feasible

- Segment-reversal move for TSP with O(1) re-indexing

- Colour-coded plots

- Half-planes shaded by quadrant for LPs

- Live plotter for TSP

- No external toolboxes

## Build & Run
1. Clone the repository to your local machine.

2. Navigate to the project directory and open in MATLAB.

3. Run scripts:

Run the Interior Point Program
```bash
>> run('lp_visualise.m')
Input file number: 149      % type an id that matches lin_prog<ID>.mat
```

Run Travelling Salesman Program
```bash
>> run('tsp_visualise.m')
Input file number: 149      % matches travel_sale<ID>.mat
```
 
## Usage
Tuning LP: adjust mu_ip, inner iteration count, or backtracking factors.

Tuning TSP: change initial temperature T or cooling factor 0.99999.

Batch runs – Wrap the solvers in a for-loop, vary the parameters, and log the final objective to benchmark different settings.

Custom data – Create a .mat file with the correct field names, place it in the repo, and pass its numeric ID when prompted (program is input agnostic so you can have your own fun with it).

## Dependencies

MATLAB R2018a+

## Numerical/ mathematical deep-dive:

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
   Given these values, the figure of the constraint region overlaid with the location of the solutions to (*µ) can be seen below:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/db430498-e239-40b7-bbf1-8fcce4784746)
   

3. Travel.m solves a Travelling Salesman Problem using simulated annealing i.e. it finds a near-optimal shortest route between 40 coordinates (p(i), q(i)) with i=1,...,40).
   Vectors p and q are loaded from travel_sale149.mat via load_data_travel_sale.m.
   Given these values, the plot of the 40 coordinates together with the near-optimal route can be seen below:
   
   ![image](https://github.com/flaviamihaela/optimisation_tasks/assets/55638247/5de1e529-1fc2-4077-862f-dad88c09fbde)

   When implementing simulated annealing it is common to perform more than one search.
   This program uses a randomized method because the global search for a “spatially” big function is computationally prohibitive.
   Therefore a different plot will be generated every time - rather than having one optimal route distance, this program provides a range of near-optimal short routes.

