export type Level = {size_y: number, block_type: string}

export type Block = {
  PhysicalBlock: Instance?,
  Type: string,
  Position: Vector3,
  ChunkId: number
}

export type Chunk = {
  Id: number, 
  Loaded: boolean, 
  Position: Vector3, 
  Blocks: {Block}
}

local mod = {}

return mod