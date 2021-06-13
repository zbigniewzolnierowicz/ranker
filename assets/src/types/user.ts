import { IPool } from "./pool";

export interface IUser<TPool = IPool> {
    id: number
    email: string
    provider: string
    spendable_points: number
    pool: TPool
}