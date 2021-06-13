import { IPool } from "./pool";

export interface IUser {
    id: number
    email: string
    provider: string
    points: IPool
}