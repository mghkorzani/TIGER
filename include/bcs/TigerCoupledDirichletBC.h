/**************************************************************************/
/*  TIGER - THMC sImulator for GEoscience Research                        */
/*                                                                        */
/*  Copyright (C) 2017 by Maziar Gholami Korzani                          */
/*  Karlsruhe Institute of Technology, Institute of Applied Geosciences   */
/*  Division of Geothermal Research                                       */
/*                                                                        */
/*  This file is part of TIGER App                                        */
/*                                                                        */
/*  This program is free software: you can redistribute it and/or modify  */
/*  it under the terms of the GNU General Public License as published by  */
/*  the Free Software Foundation, either version 3 of the License, or     */
/*  (at your option) any later version.                                   */
/*                                                                        */
/*  This program is distributed in the hope that it will be useful,       */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          */
/*  GNU General Public License for more details.                          */
/*                                                                        */
/*  You should have received a copy of the GNU General Public License     */
/*  along with this program.  If not, see <http://www.gnu.org/licenses/>  */
/**************************************************************************/

#ifndef TIGERCOUPLEDDRICHLETBC2_H
#define TIGERCOUPLEDDRICHLETBC2_H

// #include "IntegratedBC.h"
#include "NodalBC.h"

class TigerCoupledDirichletBC2;

template <>
InputParameters validParams<TigerCoupledDirichletBC2>();

/* The residual is simply -test*k*grad_u*normal which is the term
 * you get from integration by parts.
 *
 * See also: Griffiths, David F. "The 'no boundary condition' outflow
 * boundary condition.", International Journal for Numerical Methods
 * in Fluids, vol. 24, no. 4, 1997, pp. 393-411.
 */
class TigerCoupledDirichletBC2 : public NodalBC
{
public:
  TigerCoupledDirichletBC2(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;
  virtual Real computeQpOffDiagJacobian(unsigned jvar) override;

  // const MaterialProperty<RankTwoTensor> & _k_vis;
const VariableValue & _coupled_var;
unsigned _coupled_var_number;
};

#endif // TIGERCOUPLEDDRICHLETBC2_H