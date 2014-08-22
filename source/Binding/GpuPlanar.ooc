//
// Copyright (c) 2011-2014 Simon Mika <simon@mika.se>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

use ooc-draw
use ooc-math
import OpenGLES3/Texture
import OpenGLES3/lib/gles, OpenGLES3/Fbo
import GpuImage

GpuPlanar: abstract class extends GpuImage {
  init: func (size: IntSize2D, type: TextureType, y: Pointer, u: Pointer, v: Pointer) {
    super(size)
    this _channelCount = 3
    this _textures = Texture[this _channelCount] new()
    this _textures[0] = Texture create(type, size width, size height, y)
    this _textures[1] = Texture create(type, size width / 2, size height / 2, u)
    this _textures[2] = Texture create(type, size width / 2, size height / 2, v)
  }

  dispose: func {
    for(i in 0..this _channelCount)
      this _textures[i] dispose()
  }

  bind: func {
    for(i in 0..this _channelCount) {
      this _textures[i] bind (i)
    }
  }

}
