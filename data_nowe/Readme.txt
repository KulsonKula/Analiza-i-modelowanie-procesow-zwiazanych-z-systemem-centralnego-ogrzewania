If you use our model, simulator, or dataset, please cite our paper: 

M.J. Ritchie, J.A.A. Engelbrecht, M.J. Booysen, "A probabilistic hot water usage model and simulator for use in residential energy management", In press, Energy & Buildings

You may also be interested in 
M.J. Booysen, J.A.A. Engelbrecht, M.J. Ritchie, M. Apperley, A.H. Cloete,  “How much energy can optimal control of domestic water heating save?”, Energy for Sustainable Development, vol 51 pp. 73-85 2019
M.J. Ritchie, J.J.A. Engelbrecht, M.J. Booysen, “Practically-achievable energy savings with the optimal control of stratified water heaters with predicted usage” ,  Energies (MDPI), 2021
J.J.A. Engelbrecht, M.J. Ritchie, M.J. Booysen ” Optimal schedule and temperature control of stratified water heaters” ,  Energy for Sustainable Development, 2021

--------------------------------------------------------------------------------------------------------------------------------------

How To Use:

1. Import Libraries: Run Block A
2. Set Constants and Parameters: Run Block B
3. Define Model Functions: Run Block C
4. Generate Model and Save Synthetic Water Profiles: Run Block D

Additional Information:
Model Modes: 	Real(default) - Produces a realistic representation of a water profile, obeying actual model probabilities and parameters are picked from fitted distributions.

		Nominal(for most likely case) - A nominal water profile, events are picked from most likely Volume Cluster and mean parameters are picked from fitted distributions.

		Conservative(for optimisation purposes) - A conservative water profile, events are picked from largest Volume Cluster and most conservative parameters are picked from fitted distributions.

EWH Range:	List of indices of EWH profiles to consider from Input Data.

Directories: 	- Input data is read from "Source Data/"
		- Output data is saved to "Final Data/"

