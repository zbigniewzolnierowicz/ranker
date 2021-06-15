import { IPool } from './pool'
import { IReward } from './reward'

export interface IUser {
  id: number
  email: string
  provider: string
  spendable_points: number
  pool?: IPool
  rewards?: IReward[]
}
