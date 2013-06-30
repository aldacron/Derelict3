module derelict.opengl3.xext;

private import derelict.util.system;

static if(Derelict_OS_Posix && !Derelict_OS_Mac)
{
	private
	{
		import derelict.opengl3.types;
		import derelict.opengl3.constants;
		import derelict.opengl3.internal;
		import derelict.opengl3.glx;
		import derelict.util.xtypes;
	}

	alias ulong int64_t;
	alias ulong uint64_t;
	alias int int32_t;
	alias XID GLXContextID;
	alias XID GLXVideoCaptureDeviceNV;
	alias XID GLXPbufferSGIX;
	alias uint GLXVideoDeviceNV;
	struct __GLXFBConfigRec;
	alias __GLXFBConfigRec GLXFBConfigSGIX;

	enum : uint
	{
		GLX_WINDOW_BIT                    = 0x00000001,
		GLX_PIXMAP_BIT                    = 0x00000002,
		GLX_PBUFFER_BIT                   = 0x00000004,
		GLX_RGBA_BIT                      = 0x00000001,
		GLX_COLOR_INDEX_BIT               = 0x00000002,
		GLX_PBUFFER_CLOBBER_MASK          = 0x08000000,
		GLX_FRONT_LEFT_BUFFER_BIT         = 0x00000001,
		GLX_FRONT_RIGHT_BUFFER_BIT        = 0x00000002,
		GLX_BACK_LEFT_BUFFER_BIT          = 0x00000004,
		GLX_BACK_RIGHT_BUFFER_BIT         = 0x00000008,
		GLX_AUX_BUFFERS_BIT               = 0x00000010,
		GLX_DEPTH_BUFFER_BIT              = 0x00000020,
		GLX_STENCIL_BUFFER_BIT            = 0x00000040,
		GLX_ACCUM_BUFFER_BIT              = 0x00000080,
		GLX_CONFIG_CAVEAT                 = 0x20,
		GLX_X_VISUAL_TYPE                 = 0x22,
		GLX_TRANSPARENT_TYPE              = 0x23,
		GLX_TRANSPARENT_INDEX_VALUE       = 0x24,
		GLX_TRANSPARENT_RED_VALUE         = 0x25,
		GLX_TRANSPARENT_GREEN_VALUE       = 0x26,
		GLX_TRANSPARENT_BLUE_VALUE        = 0x27,
		GLX_TRANSPARENT_ALPHA_VALUE       = 0x28,
		GLX_DONT_CARE                     = 0xFFFFFFFF,
		GLX_NONE                          = 0x8000,
		GLX_SLOW_CONFIG                   = 0x8001,
		GLX_TRUE_COLOR                    = 0x8002,
		GLX_DIRECT_COLOR                  = 0x8003,
		GLX_PSEUDO_COLOR                  = 0x8004,
		GLX_STATIC_COLOR                  = 0x8005,
		GLX_GRAY_SCALE                    = 0x8006,
		GLX_STATIC_GRAY                   = 0x8007,
		GLX_TRANSPARENT_RGB               = 0x8008,
		GLX_TRANSPARENT_INDEX             = 0x8009,
		GLX_VISUAL_ID                     = 0x800B,
		GLX_SCREEN                        = 0x800C,
		GLX_NON_CONFORMANT_CONFIG         = 0x800D,
		GLX_DRAWABLE_TYPE                 = 0x8010,
		GLX_RENDER_TYPE                   = 0x8011,
		GLX_X_RENDERABLE                  = 0x8012,
		GLX_FBCONFIG_ID                   = 0x8013,
		GLX_RGBA_TYPE                     = 0x8014,
		GLX_COLOR_INDEX_TYPE              = 0x8015,
		GLX_MAX_PBUFFER_WIDTH             = 0x8016,
		GLX_MAX_PBUFFER_HEIGHT            = 0x8017,
		GLX_MAX_PBUFFER_PIXELS            = 0x8018,
		GLX_PRESERVED_CONTENTS            = 0x801B,
		GLX_LARGEST_PBUFFER               = 0x801C,
		GLX_WIDTH                         = 0x801D,
		GLX_HEIGHT                        = 0x801E,
		GLX_EVENT_MASK                    = 0x801F,
		GLX_DAMAGED                       = 0x8020,
		GLX_SAVED                         = 0x8021,
		GLX_WINDOW                        = 0x8022,
		GLX_PBUFFER                       = 0x8023,
		GLX_PBUFFER_HEIGHT                = 0x8040,
	    GLX_PBUFFER_WIDTH                 = 0x8041
	}

	struct GLXHyperpipeNetworkSGIX {
		char    pipeName[80]; /* Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] */
		int     networkId;
	}
	
	struct GLXHyperpipeConfigSGIX {
		char    pipeName[80]; /* Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] */
		int     chann;
		uint participationType;
		int     timeSlice;
	}
	
	struct GLXPipeRect {
		char pipeName[80]; /* Should be [GLX_HYPERPIPE_PIPE_NAME NGTH_SGIX] */
		int srcXOrigin, srcYOrigin, srcWidth, srcHeight;
		int destXOrigin, destYOrigin, destWidth, destHeight;
	}
	
	struct GLXPipeRectLimits {
		char pipeNa[80]; /* Should be [GLX_HYPERPIPE_PIPE_NAME_LENGTH_SGIX] */
		int XOrigin, YOrigin, maxHeight, maxWidth;
	}

	// functions as types
	extern(System)
	{
		//GLX version 1.3
		alias nothrow GLXFBConfig* function(Display* dpy, int screen, int* nelements) da_glXGetFBConfigs;
		alias nothrow GLXFBConfig* function(Display* dpy, int screen, const int* attrib_list, int* nelements) da_glXChooseFBConfig;
		alias nothrow int function(Display* dpy, GLXFBConfig config, int attribute, int* value) da_glXGetFBConfigAttrib;
		alias nothrow XVisualInfo* function(Display* dpy, GLXFBConfig config) da_glXGetVisualFromFBConfig;
		alias nothrow GLXWindow function(Display* dpy, GLXFBConfig config, Window win, const int* attrib_list) da_glXCreateWindow;
		alias nothrow void function(Display* dpy, GLXWindow win) da_glXDestroyWindow;
		alias nothrow GLXPixmap function(Display* dpy, GLXFBConfig config, Pixmap pixmap, const int* attrib_list) da_glXCreatePixmap;
		alias nothrow void function(Display* dpy, GLXPixmap pixmap) da_glXDestroyPixmap;
		alias nothrow GLXPbuffer function(Display* dpy, GLXFBConfig config, const int* attrib_list) da_glXCreatePbuffer;
		alias nothrow void function(Display* dpy, GLXPbuffer pbuf) da_glXDestroyPbuffer;
		alias nothrow void function(Display* dpy, GLXDrawable draw, int attribute, uint* value) da_glXQueryDrawable;
		alias nothrow GLXContext function(Display* dpy, GLXFBConfig config, int render_type, GLXContext share_list, Bool direct) da_glXCreateNewContext;
		alias nothrow Bool function(Display* dpy, GLXDrawable draw, GLXDrawable read, GLXContext ctx) da_glXMakeContextCurrent;
		alias nothrow GLXDrawable function() da_glXGetCurrentReadDrawable;
		alias nothrow int function(Display* dpy, GLXContext ctx, int attribute, int* value) da_glXQueryContext;
		alias nothrow void function(Display* dpy, GLXDrawable draw, ulong event_mask) da_glXSelectEvent;
		alias nothrow void function(Display* dpy, GLXDrawable draw, ulong* event_mask) da_glXGetSelectedEvent;

		// GLX version 1.4
		alias nothrow __GLXextFuncPtr function(const GLubyte *procName) da_glXGetProcAddress;

		// GLX_ARB_create_context
		alias nothrow GLXContext function(Display *dpy, GLXFBConfig config, GLXContext share_context, Bool direct, const int *attrib_list) da_glXCreateContextAttribsARB;

		// GLX_ARB_get_proc_address
		alias nothrow __GLXextFuncPtr function(const GLubyte *procName) da_glXGetProcAddressARB;

		// GLX_EXT_import_context
		alias nothrow Display* function() da_glXGetCurrentDisplayEXT;
		alias nothrow int function(Display* dpy, GLXContext context, int attribute, int* value) da_glXQueryContextInfoEXT;
		alias nothrow GLXContextID function(const GLXContext context) da_glXGetContextIDEXT;
		alias nothrow GLXContext function(Display* dpy, GLXContextID contextID) da_glXImportContextEXT;
		alias nothrow void function(Display* dpy, GLXContext context) da_glXFreeContextEXT;

		// GLX_EXT_swap_control
		alias nothrow void function(Display* dpy, GLXDrawable drawable, int interval) da_glXSwapIntervalEXT;

		// GLX_EXT_texture_from_pixmap
		alias nothrow void function(Display* dpy, GLXDrawable drawable, int buffer, const int* attrib_list) da_glXBindTexImageEXT;
		alias nothrow void function(Display* dpy, GLXDrawable drawable, int buffer) da_glXReleaseTexImageEXT;

		// GLX_MESA_agp_offset
		alias nothrow uint function(const void* pointer) da_glXGetAGPOffsetMESA;

		// GLX_MESA_pixmap_colormap
		alias nothrow GLXPixmap function(Display* dpy, XVisualInfo* visual, Pixmap pixmap, Colormap cmap) da_glXCreateGLXPixmapMESA;

		// GLX_MESA_release_buffers
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable) da_glXReleaseBuffersMESA;

		// GLX_MESA_set_3dfx_mode
		alias nothrow Bool function(int mode) da_glXSet3DfxModeMESA;

		// GLX_NV_copy_image
		alias nothrow void function(Display* dpy, GLXContext srcCtx, GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLXContext dstCtx, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei width, GLsizei height, GLsizei depth) da_glXCopyImageSubDataNV;

		// GLX_NV_present_video
		alias nothrow uint* function(Display* dpy, int screen, int* nelements) da_glXEnumerateVideoDevicesNV;
		alias nothrow int function(Display* dpy, uint video_slot, uint video_device, const int* attrib_list) da_glXBindVideoDeviceNV;

		// GLX_NV_swap_group
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, GLuint group) da_glXJoinSwapGroupNV;
		alias nothrow Bool function(Display* dpy, GLuint group, GLuint barrier) da_glXBindSwapBarrierNV;
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, GLuint* group, GLuint* barrier) da_glXQuerySwapGroupNV;
		alias nothrow Bool function(Display* dpy, int screen, GLuint* maxGroups, GLuint* maxBarriers) da_glXQueryMaxSwapGroupsNV;
		alias nothrow Bool function(Display* dpy, int screen, GLuint* count) da_glXQueryFrameCountNV;
		alias nothrow Bool function(Display* dpy, int screen) da_glXResetFrameCountNV;

		// GLX_NV_video_capture
		alias nothrow int function(Display* dpy, uint video_capture_slot, GLXVideoCaptureDeviceNV device) da_glXBindVideoCaptureDeviceNV;
		alias nothrow GLXVideoCaptureDeviceNV* function(Display* dpy, int screen, int* nelements) da_glXEnumerateVideoCaptureDevicesNV;
		alias nothrow void function(Display* dpy, GLXVideoCaptureDeviceNV device) da_glXLockVideoCaptureDeviceNV;
		alias nothrow int function(Display* dpy, GLXVideoCaptureDeviceNV device, int attribute, int* value) da_glXQueryVideoCaptureDeviceNV;
		alias nothrow void function(Display* dpy, GLXVideoCaptureDeviceNV device) da_glXReleaseVideoCaptureDeviceNV;

		// GLX_NV_video_output
		alias nothrow int function(Display* dpy, int screen, int numVideoDevices, GLXVideoDeviceNV* pVideoDevice) da_glXGetVideoDeviceNV;
		alias nothrow int function(Display* dpy, int screen, GLXVideoDeviceNV VideoDevice) da_glXReleaseVideoDeviceNV;
		alias nothrow int function(Display* dpy, GLXVideoDeviceNV VideoDevice, GLXPbuffer pbuf, int iVideoBuffer) da_glXBindVideoImageNV;
		alias nothrow int function(Display* dpy, GLXPbuffer pbuf) da_glXReleaseVideoImageNV;
		alias nothrow int function(Display* dpy, GLXPbuffer pbuf, int iBufferType, ulong* pulCounterPbuffer, GLboolean bBlock) da_glXSendPbufferToVideoNV;
		alias nothrow int function(Display* dpy, int screen, GLXVideoDeviceNV VideoDevice, ulong* pulCounterOutputPbuffer, ulong* pulCounterOutputVideo) da_glXGetVideoInfoNV;

		// GLX_OML_sync_control
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, int64_t* ust, int64_t* msc, int64_t* sbc) da_glXGetSyncValuesOML;
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, int32_t* numerator, int32_t* denominator) da_glXGetMscRateOML;
		alias nothrow int64_t function(Display* dpy, GLXDrawable drawable, int64_t target_msc, int64_t divisor, int64_t remainder) da_glXSwapBuffersMscOML;
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, int64_t target_msc, int64_t divisor, int64_t remainder, int64_t* ust, int64_t* msc, int64_t* sbc) da_glXWaitForMscOML;
		alias nothrow Bool function(Display* dpy, GLXDrawable drawable, int64_t target_sbc, int64_t* ust, int64_t* msc, int64_t* sbc) da_glXWaitForSbcOML;

		// GLX_SGIX_fbconfig
		alias nothrow int function(Display* dpy, GLXFBConfigSGIX config, int attribute, int* value) da_glXGetFBConfigAttribSGIX;
		alias nothrow GLXFBConfigSGIX* function(Display* dpy, int screen, int* attrib_list, int* nelements) da_glXChooseFBConfigSGIX;
		alias nothrow GLXPixmap function(Display* dpy, GLXFBConfigSGIX config, Pixmap pixmap) da_glXCreateGLXPixmapWithConfigSGIX;
		alias nothrow GLXContext function(Display* dpy, GLXFBConfigSGIX config, int render_type, GLXContext share_list, Bool direct) da_glXCreateContextWithConfigSGIX;
		alias nothrow XVisualInfo* function(Display* dpy, GLXFBConfigSGIX config) da_glXGetVisualFromFBConfigSGIX;
		alias nothrow GLXFBConfigSGIX function(Display* dpy, XVisualInfo* vis) da_glXGetFBConfigFromVisualSGIX;

		// GLX_SGIX_hyperpipe
		alias nothrow GLXHyperpipeNetworkSGIX* function(Display* dpy, int* npipes) da_glXQueryHyperpipeNetworkS;
		alias nothrow int function(Display* dpy, int networkId, int npipes, GLXHyperpipeConfigSGIX* cfg, int* hpId) da_glXHyperpipeConfigSGIX;
		alias nothrow GLXHyperpipeConfigSGIX* function(Display* dpy, int hpId, int* npipes) da_glXQueryHyperpipeConfigSGIX;
		alias nothrow int function(Display* dpy, int hpId) da_glXDestroyHyperpipeConfigSGIX;
		alias nothrow int function(Display* dpy, int hpId) da_glXBindHyperpipeSGIX;
		alias nothrow int function(Display* dpy, int timeSlice, int attrib, int size, void* attribList, void* returnAttribList) da_glXQueryHyperpipeBestAttribSGIX;
		alias nothrow int function(Display* dpy, int timeSlice, int attrib, int size, void* attribList) da_glXHyperpipeAttribSGIX;
		alias nothrow int function(Display* dpy, int timeSlice, int attrib, int size, void* returnAttribList) da_glXQueryHyperpipeAttribSGIX;

		// GLX_SGIX_pbuffer
		alias nothrow GLXPbufferSGIX function(Display* dpy, GLXFBConfigSGIX config, uint width, uint height, int* attrib_list) da_glXCreateGLXPbufferSGIX;
		alias nothrow void function(Display* dpy, GLXPbufferSGIX pbuf) da_glXDestroyGLXPbufferSGIX;
		alias nothrow int function(Display* dpy, GLXPbufferSGIX pbuf, int attribute, uint* value) da_glXQueryGLXPbufferSGIX;
		alias nothrow void function(Display* dpy, GLXDrawable drawable, ulong mask) da_glXSelectEventSGIX;
		alias nothrow void function(Display* dpy, GLXDrawable drawable, ulong* mask) da_glXGetSelectedEventSGIX;

		// GLX_SGIX_swap_barrier
		alias nothrow void function(Display* dpy, GLXDrawable drawable, int barrier) da_glXBindSwapBarrierSGIX;
		alias nothrow Bool function(Display* dpy, int screen, int* max) da_glXQueryMaxSwapBarriersSGIX;

		// GLX_SGIX_swap_group
		alias nothrow void function(Display* dpy, GLXDrawable drawable, GLXDrawable member) da_glXJoinSwapGroupSGIX;

		// GLX_SGIX_video_source
		alias nothrow int function(Display* display, int screen, int channel, Window window) da_glXBindChannelToWindowSGIX;
		alias nothrow int function(Display* display, int screen, int channel, int x, int y, int w, int h) da_glXChannelRectSGIX;
		alias nothrow int function(Display* display, int screen, int channel, int* dx, int* dy, int* dw, int* dh) da_glXQueryChannelRectSGIX;
		alias nothrow int function(Display* display, int screen, int channel, int* x, int* y, int* w, int* h) da_glXQueryChannelDeltasSGIX;
		alias nothrow int function(Display* display, int screen, int channel, GLenum synctype) da_glXChannelRectSyncSGIX;

		// GLX_SGI_cushion
		alias nothrow void function(Display* dpy, Window window, float cushion) da_glXCushionSGI;

		// GLX_SGI_swap_control
		alias nothrow int function(int interval) da_glXSwapIntervalSGI;

		// GLX_SGI_video_sync
		alias nothrow int function(uint* count) da_glXGetVideoSyncSGI;
		alias nothrow int function(int divisor, int remainder, uint* count) da_glXWaitVideoSyncSGI;

		// GLX_SUN_get_transparent_index
		alias nothrow Status function(Display* dpy, Window overlay, Window underlay, long* pTransparentIndex) da_glXGetTransparentIndexSUN;
	}

	// function types
	alias void function() __GLXextFuncPtr;

	// function declarations
	__gshared
	{
		//GLX version 1.3
		da_glXGetFBConfigs glXGetFBConfigs;
		da_glXChooseFBConfig glXChooseFBConfig;
		da_glXGetFBConfigAttrib glXGetFBConfigAttrib;
		da_glXGetVisualFromFBConfig glXGetVisualFromFBConfig;
		da_glXCreateWindow glXCreateWindow;
		da_glXDestroyWindow glXDestroyWindow;
		da_glXCreatePixmap glXCreatePixmap;
		da_glXDestroyPixmap glXDestroyPixmap;
		da_glXCreatePbuffer glXCreatePbuffer;
		da_glXDestroyPbuffer glXDestroyPbuffer;
		da_glXQueryDrawable glXQueryDrawable;
		da_glXCreateNewContext glXCreateNewContext;
		da_glXMakeContextCurrent glXMakeContextCurrent;
		da_glXGetCurrentReadDrawable glXGetCurrentReadDrawable;
		da_glXQueryContext glXQueryContext;
		da_glXSelectEvent glXSelectEvent;
		da_glXGetSelectedEvent glXGetSelectedEvent;
		
		// GLX version 1.4
		da_glXGetProcAddress glXGetProcAddress;
		
		// GLX_ARB_create_context
		da_glXCreateContextAttribsARB glXCreateContextAttribsARB;
		
		// GLX_ARB_get_proc_address
		da_glXGetProcAddressARB glXGetProcAddressARB;
		
		// GLX_EXT_import_context
		da_glXGetCurrentDisplayEXT glXGetCurrentDisplayEXT;
		da_glXQueryContextInfoEXT glXQueryContextInfoEXT;
		da_glXGetContextIDEXT glXGetContextIDEXT;
		da_glXImportContextEXT glXImportContextEXT;
		da_glXFreeContextEXT glXFreeContextEXT;
		
		// GLX_EXT_swap_control
		da_glXSwapIntervalEXT glXSwapIntervalEXT;
		
		// GLX_EXT_texture_from_pixmap
		da_glXBindTexImageEXT glXBindTexImageEXT;
		da_glXReleaseTexImageEXT glXReleaseTexImageEXT;
		
		// GLX_MESA_agp_offset
		da_glXGetAGPOffsetMESA glXGetAGPOffsetMESA;
		
		// GLX_MESA_pixmap_colormap
		da_glXCreateGLXPixmapMESA glXCreateGLXPixmapMESA;
		
		// GLX_MESA_release_buffers
		da_glXReleaseBuffersMESA glXReleaseBuffersMESA;
		
		// GLX_MESA_set_3dfx_mode
		da_glXSet3DfxModeMESA glXSet3DfxModeMESA;
		
		// GLX_NV_copy_image
		da_glXCopyImageSubDataNV glXCopyImageSubDataNV;
		
		// GLX_NV_present_video
		da_glXEnumerateVideoDevicesNV glXEnumerateVideoDevicesNV;
		da_glXBindVideoDeviceNV glXBindVideoDeviceNV;
		
		// GLX_NV_swap_group
		da_glXJoinSwapGroupNV glXJoinSwapGroupNV;
		da_glXBindSwapBarrierNV glXBindSwapBarrierNV;
		da_glXQuerySwapGroupNV glXQuerySwapGroupNV;
		da_glXQueryMaxSwapGroupsNV glXQueryMaxSwapGroupsNV;
		da_glXQueryFrameCountNV glXQueryFrameCountNV;
		da_glXResetFrameCountNV glXResetFrameCountNV;
		
		// GLX_NV_video_capture
		da_glXBindVideoCaptureDeviceNV glXBindVideoCaptureDeviceNV;
		da_glXEnumerateVideoCaptureDevicesNV glXEnumerateVideoCaptureDevicesNV;
		da_glXLockVideoCaptureDeviceNV glXLockVideoCaptureDeviceNV;
		da_glXQueryVideoCaptureDeviceNV glXQueryVideoCaptureDeviceNV;
		da_glXReleaseVideoCaptureDeviceNV glXReleaseVideoCaptureDeviceNV;
		
		// GLX_NV_video_output
		da_glXGetVideoDeviceNV glXGetVideoDeviceNV;
		da_glXReleaseVideoDeviceNV glXReleaseVideoDeviceNV;
		da_glXBindVideoImageNV glXBindVideoImageNV;
		da_glXReleaseVideoImageNV glXReleaseVideoImageNV;
		da_glXSendPbufferToVideoNV glXSendPbufferToVideoNV;
		da_glXGetVideoInfoNV glXGetVideoInfoNV;
		
		// GLX_OML_sync_control
		da_glXGetSyncValuesOML glXGetSyncValuesOML;
		da_glXGetMscRateOML glXGetMscRateOML;
		da_glXSwapBuffersMscOML glXSwapBuffersMscOML;
		da_glXWaitForMscOML glXWaitForMscOML;
		da_glXWaitForSbcOML glXWaitForSbcOML;
		
		// GLX_SGIX_fbconfig
		da_glXGetFBConfigAttribSGIX glXGetFBConfigAttribSGIX;
		da_glXChooseFBConfigSGIX glXChooseFBConfigSGIX;
		da_glXCreateGLXPixmapWithConfigSGIX glXCreateGLXPixmapWithConfigSGIX;
		da_glXCreateContextWithConfigSGIX glXCreateContextWithConfigSGIX;
		da_glXGetVisualFromFBConfigSGIX glXGetVisualFromFBConfigSGIX;
		da_glXGetFBConfigFromVisualSGIX glXGetFBConfigFromVisualSGIX;
		
		// GLX_SGIX_hyperpipe
		da_glXQueryHyperpipeNetworkS glXQueryHyperpipeNetworkS;
		da_glXHyperpipeConfigSGIX glXHyperpipeConfigSGIX;
		da_glXQueryHyperpipeConfigSGIX glXQueryHyperpipeConfigSGIX;
		da_glXDestroyHyperpipeConfigSGIX glXDestroyHyperpipeConfigSGIX;
		da_glXBindHyperpipeSGIX glXBindHyperpipeSGIX;
		da_glXQueryHyperpipeBestAttribSGIX glXQueryHyperpipeBestAttribSGIX;
		da_glXHyperpipeAttribSGIX glXHyperpipeAttribSGIX;
		da_glXQueryHyperpipeAttribSGIX glXQueryHyperpipeAttribSGIX;
		
		// GLX_SGIX_pbuffer
		da_glXCreateGLXPbufferSGIX glXCreateGLXPbufferSGIX;
		da_glXDestroyGLXPbufferSGIX glXDestroyGLXPbufferSGIX;
		da_glXQueryGLXPbufferSGIX glXQueryGLXPbufferSGIX;
		da_glXSelectEventSGIX glXSelectEventSGIX;
		da_glXGetSelectedEventSGIX glXGetSelectedEventSGIX;
		
		// GLX_SGIX_swap_barrier
		da_glXBindSwapBarrierSGIX glXBindSwapBarrierSGIX;
		da_glXQueryMaxSwapBarriersSGIX glXQueryMaxSwapBarriersSGIX;
		
		// GLX_SGIX_swap_group
		da_glXJoinSwapGroupSGIX glXJoinSwapGroupSGIX;
		
		// GLX_SGIX_video_source
		da_glXBindChannelToWindowSGIX glXBindChannelToWindowSGIX;
		da_glXChannelRectSGIX glXChannelRectSGIX;
		da_glXQueryChannelRectSGIX glXQueryChannelRectSGIX;
		da_glXQueryChannelDeltasSGIX glXQueryChannelDeltasSGIX;
		da_glXChannelRectSyncSGIX glXChannelRectSyncSGIX;
		
		// GLX_SGI_cushion
		da_glXCushionSGI glXCushionSGI;
		
		// GLX_SGI_swap_control
		da_glXSwapIntervalSGI glXSwapIntervalSGI;
		
		// GLX_SGI_video_sync
		da_glXGetVideoSyncSGI glXGetVideoSyncSGI;
		da_glXWaitVideoSyncSGI glXWaitVideoSyncSGI;
		
		// GLX_SUN_get_transparent_index
		da_glXGetTransparentIndexSUN glXGetTransparentIndexSUN;
	}

	private __gshared bool _GLX_ARB_create_context;
	private __gshared bool _GLX_ARB_get_proc_address;
	private __gshared bool _GLX_EXT_import_context;
	private __gshared bool _GLX_EXT_swap_control;
	private __gshared bool _GLX_EXT_texture_from_pixmap;
	private __gshared bool _GLX_MESA_agp_offset;
	private __gshared bool _GLX_MESA_pixmap_colormap;
	private __gshared bool _GLX_MESA_release_buffers;
	private __gshared bool _GLX_MESA_set_3dfx_mode;
	private __gshared bool _GLX_NV_copy_image;
	private __gshared bool _GLX_NV_present_video;
	private __gshared bool _GLX_NV_swap_group;
	private __gshared bool _GLX_NV_video_capture;
	private __gshared bool _GLX_NV_video_output;
	private __gshared bool _GLX_OML_sync_control;
	private __gshared bool _GLX_SGIX_fbconfig;
	private __gshared bool _GLX_SGIX_hyperpipe;
	private __gshared bool _GLX_SGIX_pbuffer;
	private __gshared bool _GLX_SGIX_swap_barrier;
	private __gshared bool _GLX_SGIX_swap_group;
	private __gshared bool _GLX_SGIX_video_source;
	private __gshared bool _GLX_SGI_cushion;
	private __gshared bool _GLX_SGI_swap_control;
	private __gshared bool _GLX_SGI_video_sync;
	private __gshared bool _GLX_SUN_get_transparent_index;
	
	bool GLX_ARB_create_context() @property { return _GLX_ARB_create_context; }
	bool GLX_ARB_get_proc_address() @property { return _GLX_ARB_get_proc_address; }
	bool GLX_EXT_import_context() @property { return _GLX_EXT_import_context; }
	bool GLX_EXT_swap_control() @property { return _GLX_EXT_swap_control; }
	bool GLX_EXT_texture_from_pixmap() @property { return _GLX_EXT_texture_from_pixmap; }
	bool GLX_MESA_agp_offset() @property { return _GLX_MESA_agp_offset; }
	bool GLX_MESA_pixmap_colormap() @property { return _GLX_MESA_pixmap_colormap; }
	bool GLX_MESA_release_buffers() @property { return _GLX_MESA_release_buffers; }
	bool GLX_MESA_set_3dfx_mode() @property { return _GLX_MESA_set_3dfx_mode; }
	bool GLX_NV_copy_image() @property { return _GLX_NV_copy_image; }
	bool GLX_NV_present_video() @property { return _GLX_NV_present_video; }
	bool GLX_NV_swap_group() @property { return _GLX_NV_swap_group; }
	bool GLX_NV_video_capture() @property { return _GLX_NV_video_capture; }
	bool GLX_NV_video_output() @property { return _GLX_NV_video_output; }
	bool GLX_OML_sync_control() @property { return _GLX_OML_sync_control; }
	bool GLX_SGIX_fbconfig() @property { return _GLX_SGIX_fbconfig; }
	bool GLX_SGIX_hyperpipe() @property { return _GLX_SGIX_hyperpipe; }
	bool GLX_SGIX_pbuffer() @property { return _GLX_SGIX_pbuffer; }
	bool GLX_SGIX_swap_barrier() @property { return _GLX_SGIX_swap_barrier; }
	bool GLX_SGIX_swap_group() @property { return _GLX_SGIX_swap_group; }
	bool GLX_SGIX_video_source() @property { return _GLX_SGIX_video_source; }
	bool GLX_SGI_cushion() @property { return _GLX_SGI_cushion; }
	bool GLX_SGI_swap_control() @property { return _GLX_SGI_swap_control; }
	bool GLX_SGI_video_sync() @property { return _GLX_SGI_video_sync; }
	bool GLX_SUN_get_transparent_index() @property { return _GLX_SUN_get_transparent_index; }


	package void loadXEXT(GLVersion glversion)
	{
		// GLX version 1.3
		bindGLFunc(cast(void**)&glXGetFBConfigs, "glXGetFBConfigs");
		bindGLFunc(cast(void**)&glXChooseFBConfig, "glXChooseFBConfig");
		bindGLFunc(cast(void**)&glXGetFBConfigAttrib, "glXGetFBConfigAttrib");
		bindGLFunc(cast(void**)&glXGetVisualFromFBConfig, "glXGetVisualFromFBConfig");
		bindGLFunc(cast(void**)&glXCreateWindow, "glXCreateWindow");
		bindGLFunc(cast(void**)&glXDestroyWindow, "glXDestroyWindow");
		bindGLFunc(cast(void**)&glXCreatePixmap, "glXCreatePixmap");
		bindGLFunc(cast(void**)&glXDestroyPixmap, "glXDestroyPixmap");
		bindGLFunc(cast(void**)&glXCreatePbuffer, "glXCreatePbuffer");
		bindGLFunc(cast(void**)&glXDestroyPbuffer, "glXDestroyPbuffer");
		bindGLFunc(cast(void**)&glXQueryDrawable, "glXQueryDrawable");
		bindGLFunc(cast(void**)&glXCreateNewContext, "glXCreateNewContext");
		bindGLFunc(cast(void**)&glXMakeContextCurrent, "glXMakeContextCurrent");
		bindGLFunc(cast(void**)&glXGetCurrentReadDrawable, "glXGetCurrentReadDrawable");
		bindGLFunc(cast(void**)&glXQueryContext, "glXQueryContext");
		bindGLFunc(cast(void**)&glXSelectEvent, "glXSelectEvent");
		bindGLFunc(cast(void**)&glXGetSelectedEvent, "glXGetSelectedEvent");

		// GLX version 1.4
		bindGLFunc(cast(void**)&glXGetProcAddress, "glXGetProcAddress");

		// GLX_ARB_create_context
		_GLX_ARB_create_context = isExtSupported(glversion, "GLX_ARB_create_context");
		if (_GLX_ARB_create_context)
		{
			try
			{
				bindGLFunc(cast(void**)&glXCreateContextAttribsARB, "glXCreateContextAttribsARB");
				_GLX_ARB_create_context = true;
			} catch (Exception e)
			{
				_GLX_ARB_create_context = false;
			}
		}

		// GLX_ARB_get_proc_address
		_GLX_ARB_get_proc_address = isExtSupported(glversion, "GLX_ARB_get_proc_address");
		if (_GLX_ARB_get_proc_address)
		{
			try {
				bindGLFunc(cast(void**)&glXGetProcAddressARB, "glXGetProcAddressARB");
				_GLX_ARB_get_proc_address = true;
			} catch (Exception e)
			{
				_GLX_ARB_get_proc_address = false;
			}
		}

		// GLX_EXT_import_context
		_GLX_EXT_import_context = isExtSupported(glversion, "GLX_EXT_import_context");
		if (_GLX_EXT_import_context)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetCurrentDisplayEXT, "glXGetCurrentDisplayEXT");
				bindGLFunc(cast(void**)&glXQueryContextInfoEXT, "glXQueryContextInfoEXT");
				bindGLFunc(cast(void**)&glXGetContextIDEXT, "glXGetContextIDEXT");
				bindGLFunc(cast(void**)&glXImportContextEXT, "glXImportContextEXT");
				bindGLFunc(cast(void**)&glXFreeContextEXT, "glXFreeContextEXT");
				_GLX_EXT_import_context = true;
			} catch (Exception e)
			{
				_GLX_EXT_import_context = false;
			}
		}

		// GLX_EXT_swap_control
		_GLX_EXT_swap_control = isExtSupported(glversion, "GLX_EXT_swap_control");
		if (_GLX_EXT_swap_control)
		{
			try
			{
				bindGLFunc(cast(void**)&glXSwapIntervalEXT, "glXSwapIntervalEXT");
				_GLX_EXT_swap_control = true;
			} catch (Exception e)
			{
				_GLX_EXT_swap_control = false;
			}
		}

		// GLX_EXT_texture_from_pixmap
		_GLX_EXT_texture_from_pixmap = isExtSupported(glversion, "GLX_EXT_texture_from_pixmap");
		if (_GLX_EXT_texture_from_pixmap)
		{
			try
			{
				bindGLFunc(cast(void**)&glXBindTexImageEXT, "glXBindTexImageEXT");
				bindGLFunc(cast(void**)&glXReleaseTexImageEXT, "glXReleaseTexImageEXT");
				_GLX_EXT_texture_from_pixmap = true;
			} catch (Exception e)
			{
				_GLX_EXT_texture_from_pixmap = false;
			}
		}

		// GLX_MESA_agp_offset
		_GLX_MESA_agp_offset = isExtSupported(glversion, "GLX_MESA_agp_offset");
		if (_GLX_MESA_agp_offset)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetAGPOffsetMESA, "glXGetAGPOffsetMESA");
				_GLX_MESA_agp_offset = true;
			} catch (Exception e)
			{
				_GLX_MESA_agp_offset = false;
			}
		}

		// GLX_MESA_pixmap_colormap
		_GLX_MESA_pixmap_colormap = isExtSupported(glversion, "GLX_MESA_pixmap_colormap");
		if (_GLX_MESA_pixmap_colormap)
		{
			try
			{
				bindGLFunc(cast(void**)&glXCreateGLXPixmapMESA, "glXCreateGLXPixmapMESA");
				_GLX_MESA_pixmap_colormap = true;
			} catch (Exception e)
			{
				_GLX_MESA_pixmap_colormap = false;
			}
		}

		// GLX_MESA_release_buffers
		_GLX_MESA_release_buffers = isExtSupported(glversion, "GLX_MESA_release_buffers");
		if (_GLX_MESA_release_buffers)
		{
			try
			{
				bindGLFunc(cast(void**)&glXReleaseBuffersMESA, "glXReleaseBuffersMESA");
				_GLX_MESA_release_buffers = true;
			} catch (Exception e)
			{
				_GLX_MESA_release_buffers = false;
			}
		}

		// GLX_MESA_set_3dfx_mode
		_GLX_MESA_set_3dfx_mode = isExtSupported(glversion, "GLX_MESA_set_3dfx_mode");
		if (_GLX_MESA_set_3dfx_mode)
		{
			try
			{
				bindGLFunc(cast(void**)&glXSet3DfxModeMESA, "glXSet3DfxModeMESA");
				_GLX_MESA_set_3dfx_mode = true;
			} catch (Exception e)
			{
				_GLX_MESA_set_3dfx_mode = false;
			}
		}
		// GLX_NV_copy_image
		_GLX_NV_copy_image = isExtSupported(glversion, "GLX_NV_copy_image");
		if (_GLX_NV_copy_image)
		{
			try
			{
				bindGLFunc(cast(void**)&glXCopyImageSubDataNV, "glXCopyImageSubDataNV");
				_GLX_NV_copy_image = true;
			} catch (Exception e)
			{
				_GLX_NV_copy_image = false;
			}
		}

		// GLX_NV_present_video
		_GLX_NV_present_video = isExtSupported(glversion, "GLX_NV_present_video");
		if (_GLX_NV_present_video)
		{
			try
			{
				bindGLFunc(cast(void**)&glXEnumerateVideoDevicesNV, "glXEnumerateVideoDevicesNV");
				bindGLFunc(cast(void**)&glXBindVideoDeviceNV, "glXBindVideoDeviceNV");
				_GLX_NV_present_video = true;
			} catch (Exception e)
			{
				_GLX_NV_present_video = false;
			}
		}

		// GLX_NV_swap_group
		_GLX_NV_swap_group = isExtSupported(glversion, "GLX_NV_swap_group");
		if (_GLX_NV_swap_group)
		{
			try
			{
				bindGLFunc(cast(void**)&glXJoinSwapGroupNV, "glXJoinSwapGroupNV");
				bindGLFunc(cast(void**)&glXBindSwapBarrierNV, "glXBindSwapBarrierNV");
				bindGLFunc(cast(void**)&glXQuerySwapGroupNV, "glXQuerySwapGroupNV");
				bindGLFunc(cast(void**)&glXQueryMaxSwapGroupsNV, "glXQueryMaxSwapGroupsNV");
				bindGLFunc(cast(void**)&glXQueryFrameCountNV, "glXQueryFrameCountNV");
				bindGLFunc(cast(void**)&glXResetFrameCountNV, "glXResetFrameCountNV");
				_GLX_NV_swap_group = true;
			} catch (Exception e)
			{
				_GLX_NV_swap_group = false;
			}
		}

		// GLX_NV_video_capture
		_GLX_NV_video_capture = isExtSupported(glversion, "GLX_NV_video_capture");
		if (_GLX_NV_video_capture)
		{
			try
			{
				bindGLFunc(cast(void**)&glXBindVideoCaptureDeviceNV, "glXBindVideoCaptureDeviceNV");
				bindGLFunc(cast(void**)&glXEnumerateVideoCaptureDevicesNV, "glXEnumerateVideoCaptureDevicesNV");
				bindGLFunc(cast(void**)&glXLockVideoCaptureDeviceNV, "glXLockVideoCaptureDeviceNV");
				bindGLFunc(cast(void**)&glXQueryVideoCaptureDeviceNV, "glXQueryVideoCaptureDeviceNV");
				bindGLFunc(cast(void**)&glXReleaseVideoCaptureDeviceNV, "glXReleaseVideoCaptureDeviceNV");
				_GLX_NV_video_capture= true;
			} catch (Exception e)
			{
				_GLX_NV_video_capture = false;
			}
		}

		// GLX_NV_video_output
		_GLX_NV_video_output = isExtSupported(glversion, "GLX_NV_video_output");
		if (_GLX_NV_video_output)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetVideoDeviceNV, "glXGetVideoDeviceNV");
				bindGLFunc(cast(void**)&glXReleaseVideoDeviceNV, "glXReleaseVideoDeviceNV");
				bindGLFunc(cast(void**)&glXBindVideoImageNV, "glXBindVideoImageNV");
				bindGLFunc(cast(void**)&glXReleaseVideoImageNV, "glXReleaseVideoImageNV");
				bindGLFunc(cast(void**)&glXSendPbufferToVideoNV, "glXSendPbufferToVideoNV");
				bindGLFunc(cast(void**)&glXGetVideoInfoNV, "glXGetVideoInfoNV");
				_GLX_NV_video_output = true;
			} catch (Exception e)
			{
				_GLX_NV_video_output = false;
			}
		}

		// GLX_OML_sync_control
		_GLX_OML_sync_control = isExtSupported(glversion, "GLX_OML_sync_control");
		if (_GLX_OML_sync_control)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetSyncValuesOML, "glXGetSyncValuesOML");
				bindGLFunc(cast(void**)&glXGetMscRateOML, "glXGetMscRateOML");
				bindGLFunc(cast(void**)&glXSwapBuffersMscOML, "glXSwapBuffersMscOML");
				bindGLFunc(cast(void**)&glXWaitForMscOML, "glXWaitForMscOML");
				bindGLFunc(cast(void**)&glXWaitForSbcOML, "glXWaitForSbcOML");
				_GLX_OML_sync_control = true;
			} catch (Exception e)
			{
				_GLX_OML_sync_control = false;
			}
		}

		// GLX_SGIX_fbconfig
		_GLX_SGIX_fbconfig = isExtSupported(glversion, "GLX_SGIX_fbconfig");
		if (_GLX_SGIX_fbconfig)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetFBConfigAttribSGIX, "glXGetFBConfigAttribSGIX");
				bindGLFunc(cast(void**)&glXChooseFBConfigSGIX, "glXChooseFBConfigSGIX");
				bindGLFunc(cast(void**)&glXCreateGLXPixmapWithConfigSGIX, "glXCreateGLXPixmapWithConfigSGIX");
				bindGLFunc(cast(void**)&glXCreateContextWithConfigSGIX, "glXCreateContextWithConfigSGIX");
				bindGLFunc(cast(void**)&glXGetVisualFromFBConfigSGIX, "glXGetVisualFromFBConfigSGIX");
				bindGLFunc(cast(void**)&glXGetFBConfigFromVisualSGIX, "glXGetFBConfigFromVisualSGIX");
				_GLX_SGIX_fbconfig = true;
			} catch (Exception e)
			{
				_GLX_SGIX_fbconfig = false;
			}
		}

		// GLX_SGIX_hyperpipe
		_GLX_SGIX_hyperpipe = isExtSupported(glversion, "GLX_SGIX_hyperpipe");
		if (_GLX_SGIX_hyperpipe)
		{
			try
			{
				bindGLFunc(cast(void**)&glXQueryHyperpipeNetworkS, "glXQueryHyperpipeNetworkS");
				bindGLFunc(cast(void**)&glXHyperpipeConfigSGIX, "glXHyperpipeConfigSGIX");
				bindGLFunc(cast(void**)&glXQueryHyperpipeConfigSGIX, "glXQueryHyperpipeConfigSGIX");
				bindGLFunc(cast(void**)&glXDestroyHyperpipeConfigSGIX, "glXDestroyHyperpipeConfigSGIX");
				bindGLFunc(cast(void**)&glXBindHyperpipeSGIX, "glXBindHyperpipeSGIX");
				bindGLFunc(cast(void**)&glXQueryHyperpipeBestAttribSGIX, "glXQueryHyperpipeBestAttribSGIX");
				bindGLFunc(cast(void**)&glXHyperpipeAttribSGIX, "glXHyperpipeAttribSGIX");
				bindGLFunc(cast(void**)&glXQueryHyperpipeAttribSGIX, "glXQueryHyperpipeAttribSGIX");
				_GLX_SGIX_hyperpipe = true;
			} catch (Exception e)
			{
				_GLX_SGIX_hyperpipe = false;
			}
		}

		// GLX_SGIX_pbuffer
		_GLX_SGIX_pbuffer = isExtSupported(glversion, "GLX_SGIX_pbuffer");
		if (_GLX_SGIX_pbuffer)
		{
			try
			{
				bindGLFunc(cast(void**)&glXCreateGLXPbufferSGIX, "glXCreateGLXPbufferSGIX");
				bindGLFunc(cast(void**)&glXDestroyGLXPbufferSGIX, "glXDestroyGLXPbufferSGIX");
				bindGLFunc(cast(void**)&glXQueryGLXPbufferSGIX, "glXQueryGLXPbufferSGIX");
				bindGLFunc(cast(void**)&glXSelectEventSGIX, "glXSelectEventSGIX");
				bindGLFunc(cast(void**)&glXGetSelectedEventSGIX, "glXGetSelectedEventSGIX");
				_GLX_SGIX_pbuffer = true;
			} catch (Exception e)
			{
				_GLX_SGIX_pbuffer = false;
			}
		}

		// GLX_SGIX_swap_barrier
		_GLX_SGIX_swap_barrier = isExtSupported(glversion, "GLX_SGIX_swap_barrier");
		if (_GLX_SGIX_swap_barrier)
		{
			try
			{
				bindGLFunc(cast(void**)&glXBindSwapBarrierSGIX, "glXBindSwapBarrierSGIX");
				bindGLFunc(cast(void**)&glXQueryMaxSwapBarriersSGIX, "glXQueryMaxSwapBarriersSGIX");
				_GLX_SGIX_swap_barrier = true;
			} catch (Exception e)
			{
				_GLX_SGIX_swap_barrier = false;
			}
		}

		// GLX_SGIX_swap_group
		_GLX_SGIX_swap_group = isExtSupported(glversion, "GLX_SGIX_swap_group");
		if (_GLX_SGIX_swap_group)
		{
			try
			{
				bindGLFunc(cast(void**)&glXJoinSwapGroupSGIX, "glXJoinSwapGroupSGIX");
				_GLX_SGIX_swap_group = true;
			} catch (Exception e)
			{
				_GLX_SGIX_swap_group = false;
			}
		}
		// GLX_SGIX_video_source
		_GLX_SGIX_video_source = isExtSupported(glversion, "GLX_SGIX_video_source");
		if (_GLX_SGIX_video_source)
		{
			try
			{
				bindGLFunc(cast(void**)&glXBindChannelToWindowSGIX, "glXBindChannelToWindowSGIX");
				bindGLFunc(cast(void**)&glXChannelRectSGIX, "glXChannelRectSGIX");
				bindGLFunc(cast(void**)&glXQueryChannelRectSGIX, "glXQueryChannelRectSGIX");
				bindGLFunc(cast(void**)&glXQueryChannelDeltasSGIX, "glXQueryChannelDeltasSGIX");
				bindGLFunc(cast(void**)&glXChannelRectSyncSGIX, "glXChannelRectSyncSGIX");
				_GLX_SGIX_video_source = true;
			} catch (Exception e)
			{
				_GLX_SGIX_video_source = false;
			}
		}

		// GLX_SGI_cushion
		_GLX_SGI_cushion = isExtSupported(glversion, "GLX_SGI_cushion");
		if (_GLX_SGI_cushion)
		{
			try
			{
				bindGLFunc(cast(void**)&glXCushionSGI, "glXCushionSGI");
				_GLX_SGI_cushion = true;
			} catch (Exception e)
			{
				_GLX_SGI_cushion = false;
			}
		}

		// GLX_SGI_swap_control
		_GLX_SGI_swap_control = isExtSupported(glversion, "GLX_SGI_swap_control");
		if (_GLX_SGI_swap_control)
		{
			try
			{
				bindGLFunc(cast(void**)&glXSwapIntervalSGI, "glXSwapIntervalSGI");
				_GLX_SGI_swap_control = true;
			} catch (Exception e)
			{
				_GLX_SGI_swap_control = false;
			}
		}

		// GLX_SGI_video_sync
		_GLX_SGI_video_sync = isExtSupported(glversion, "GLX_SGI_video_sync");
		if (_GLX_SGI_video_sync)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetVideoSyncSGI, "glXGetVideoSyncSGI");
				bindGLFunc(cast(void**)&glXWaitVideoSyncSGI, "glXWaitVideoSyncSGI");
				_GLX_SGI_video_sync = true;
			} catch (Exception e)
			{
				_GLX_SGI_video_sync= false;
			}
		}

		// GLX_SUN_get_transparent_index
		_GLX_SUN_get_transparent_index = isExtSupported(glversion, "GLX_SUN_get_transparent_index");
		if (_GLX_SUN_get_transparent_index)
		{
			try
			{
				bindGLFunc(cast(void**)&glXGetTransparentIndexSUN, "glXGetTransparentIndexSUN");
				_GLX_SUN_get_transparent_index = true;
			} catch (Exception e)
			{
				_GLX_SUN_get_transparent_index = false;
			}
		}
	}
}