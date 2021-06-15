import { IPool } from './pool'
import { IReward } from './reward'

export interface IUser {
  id: number
  email: string
  provider: string
  spendable_points: number
}

export interface IUserWithPool extends IUser {
  pool: IPool
}

export interface IUserWithRewards extends IUser {
  rewards: IReward[]
}

export interface IUserWithEverything extends IUserWithPool, IUserWithRewards {}
