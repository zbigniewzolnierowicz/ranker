import { Box, Button, Input } from '@chakra-ui/react'
import { FC } from 'react'
import { useForm } from 'react-hook-form'
import { IPrivateUser } from '../types/user'

export interface IUserForm {
  amount: number
}

interface ISendableUserProps {
  user: IPrivateUser
  maxPoints?: number
  onSubmit: (form: IUserForm) => void | Promise<void>
}

export const SendableUser: FC<ISendableUserProps> = ({ user, maxPoints = 10, onSubmit }) => {
  const { register, handleSubmit } = useForm<IUserForm>({ defaultValues: { amount: 5 } })
  const submit = handleSubmit(data => onSubmit(data))

  return (
    <Box
      as="form"
      onSubmit={submit}
      display="grid"
      gridTemplateColumns={['1fr', '2fr 1fr']}
      gridTemplateRows={['repeat(3, 1fr)', 'repeat(2, 1fr)']}
      width="fit-content"
      background="gray.50"
      borderRadius="lg"
      p={4}
      boxShadow="md"
    >
      {user.name}
      <Input
        gridRow="span 1 / -2"
        gridColumn="span 1 / -1"
        {...register('amount', { min: 1, max: maxPoints, required: true })}
        borderBottomRadius="none"
        type="number"
      />
      <Button
        gridRow="span 1 / -1"
        gridColumn="span 1 / -1"
        type="submit"
        borderTopRadius="none"
        colorScheme="whatsapp"
      >
        Send points
      </Button>
    </Box>
  )
}
