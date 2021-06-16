import { IPool } from './pool'
import { IReward } from './reward'

export interface IPrivateUser {
  id: number
  email: string
  name: string
}
export interface IUser extends IPrivateUser {
  provider: string
  spendable_points: number
  pool?: IPool
  rewards?: IReward[]
}
